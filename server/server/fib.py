from lib.compute import fib as fib_rs


def fib(n: int) -> int:
    """
    Computes the n-th Fibonacci number, offloading the work to a high-performance Rust function.
    """
    return fib_rs(n)
