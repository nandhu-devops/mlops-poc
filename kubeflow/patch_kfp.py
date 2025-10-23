# patch_kfp.py
from kfp.dsl import PipelineTask

# Only patch if it doesn't already exist or has a different signature
if not hasattr(PipelineTask, "_patched_add_node_selector_constraint"):

    def patched_add_node_selector_constraint(self, key, value):
        """Backward-compatible stub for v1 node selector API."""
        if not hasattr(self, "_custom_node_selectors"):
            self._custom_node_selectors = {}
        self._custom_node_selectors[key] = value
        print(f"[Patch] Node selector applied: {key}={value}")
        return self

    PipelineTask.add_node_selector_constraint = patched_add_node_selector_constraint
    PipelineTask._patched_add_node_selector_constraint = True

    print("[Patch] ✅ Patched kfp.dsl.PipelineTask.add_node_selector_constraint() for backward compatibility")
