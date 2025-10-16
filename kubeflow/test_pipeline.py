from kfp import dsl
from kfp.dsl import component

@component
def say_hello(name: str):
    print(f"Hello, {name}!")

@dsl.pipeline(name="hello-pipeline", description="Sanity check pipeline")
def hello_pipeline(name: str = "World"):
    say_hello(name=name)

