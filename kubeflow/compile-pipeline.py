#!/usr/bin/env python3
"""
Portable Kubeflow pipeline compiler helper.

Usage:
  python compile_pipeline.py yt-sentiment-pipeline.py yt-sentiment-pipeline.yaml

This script tries the common kfp compile APIs in order and reports useful errors.
"""
import sys
import importlib
from pathlib import Path

if len(sys.argv) != 3:
    print("Usage: python compile_pipeline.py <pipeline_py> <output_yaml>")
    sys.exit(2)

pipeline_py = Path(sys.argv[1]).resolve()
output_yaml = Path(sys.argv[2]).resolve()

if not pipeline_py.exists():
    print(f"Error: pipeline file not found: {pipeline_py}")
    sys.exit(2)

print("Using Python:", sys.executable)
try:
    import kfp
    print("kfp version:", getattr(kfp, "__version__", "unknown"))
except Exception as e:
    print("Error importing kfp:", e)
    print("Make sure you installed kfp in the active virtualenv: pip install 'kfp>=2.6.0,<3.0.0'")
    sys.exit(1)

# Try multiple compiler entrypoints used across versions
trials = [
    ("kfp.v2.compiler", "Compiler().compile(package_path=output, pipeline_func)"),
    ("kfp.v2.compiler.compiler", "Compiler().compile(package_path=output, pipeline_func)"),
    ("kfp.dsl.compiler", "compile -- module style"),
    ("kfp.compiler", "Compiler().compile(package_path=output, pipeline_func)")
]

last_err = None
for mod_name, note in trials:
    try:
        mod = importlib.import_module(mod_name)
        print(f"Found compiler module: {mod_name} (using {note})")
        # Attempt to call known compile entrypoints
        if mod_name.startswith("kfp.v2"):
            # kfp.v2.compiler.Compiler().compile(pipeline_func=..., package_path=...)
            Compiler = getattr(mod, "Compiler", None)
            if Compiler:
                comp = Compiler()
                # use the standard compile CLI function if available
                try:
                    # The v2 compiler expects a pipeline function object - we import the module and look for pipeline func
                    # We'll import the pipeline python file as a module and try to find a function whose name contains "pipeline"
                    spec = importlib.util.spec_from_file_location("pipeline_module", str(pipeline_py))
                    pipeline_module = importlib.util.module_from_spec(spec)
                    spec.loader.exec_module(pipeline_module)
                    # try to find a pipeline function (first callable with 'pipeline' in name)
                    pipeline_func = None
                    for name in dir(pipeline_module):
                        if "pipeline" in name.lower():
                            attr = getattr(pipeline_module, name)
                            if callable(attr):
                                pipeline_func = attr
                                print(f"Discovered pipeline function: {name}")
                                break
                    if pipeline_func is None:
                        raise RuntimeError("No pipeline function found in the python file. Please name your pipeline function with 'pipeline' in the name.")
                    comp.compile(pipeline_func=pipeline_func, package_path=str(output_yaml))
                    print("Compiled pipeline successfully to", output_yaml)
                    sys.exit(0)
                except Exception as ex:
                    last_err = ex
                    print("kfp.v2.Compiler attempt failed:", ex)
                    continue
        # Try the classic module-level compile function if present
        if hasattr(mod, "compile"):
            try:
                # import as module to call compile
                # Some versions have compile(pipeline_func, output)
                spec = importlib.util.spec_from_file_location("pipeline_module", str(pipeline_py))
                pipeline_module = importlib.util.module_from_spec(spec)
                spec.loader.exec_module(pipeline_module)
                # find pipeline function
                pipeline_func = None
                for name in dir(pipeline_module):
                    if "pipeline" in name.lower():
                        attr = getattr(pipeline_module, name)
                        if callable(attr):
                            pipeline_func = attr
                            print(f"Discovered pipeline function: {name}")
                            break
                if pipeline_func is None:
                    raise RuntimeError("No pipeline function found in the python file. Please name your pipeline function with 'pipeline' in the name.")
                # Try calling compile(pipeline_func=..., package_path=...)
                try:
                    mod.compile(pipeline_func=pipeline_func, package_path=str(output_yaml))
                except TypeError:
                    # try older signature compile(pipeline_func, output)
                    mod.compile(pipeline_func, str(output_yaml))
                print("Compiled pipeline successfully to", output_yaml)
                sys.exit(0)
            except Exception as ex:
                last_err = ex
                print(f"Module {mod_name} compile attempt failed:", ex)
                continue
    except ModuleNotFoundError:
        # not installed - continue trying others
        last_err = None
        continue
    except Exception as e:
        last_err = e
        continue

print("Failed to find a usable kfp compiler API in this environment.")
if last_err:
    print("Last error:", last_err)
print("Tips:")
print(" - Ensure you installed kfp in this venv: pip install 'kfp>=2.6.0,<3.0.0'")
print(" - If you use KFP v1 style, consider installing kfp==1.8.14 and compiling differently.")
sys.exit(1)

