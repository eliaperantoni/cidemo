from server.fib import fib
from flask import Flask

app = Flask("Fibonacci app")

@app.post("/fib/{n:int}")
def handle_fib(n: int):
    return fib(n)

def serve(**kwargs):
    app.run(**kwargs)
