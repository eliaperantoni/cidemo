from lib.cidemo_rs import fib as fib_rs

def fib(n: int) -> int:
    return fib_rs(n)

if __name__ == "__main__":
    n = 11
    print(f"fib({n}) is {fib(n)}")
