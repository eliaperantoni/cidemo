from server.fib import fib
from flask import Flask

app = Flask("Fibonacci app", static_url_path="", static_folder="lib/frontend")

@app.route("/")
def catch_all():
    return app.send_static_file("index.html")

@app.post("/fib/<int:n>")
def handle_fib(n: int):
    return str(fib(n))

def serve(**kwargs):
    app.run(**kwargs)
