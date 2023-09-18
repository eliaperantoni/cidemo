from cidemo_py.main import fib

def test_fib():
    assert [1, 1, 2, 3, 5, 8, 13, 21, 34, 55] == [
        fib(n) for n in range(1, 11)
    ]
