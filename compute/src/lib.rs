use pyo3::prelude::*;

fn fib(n: i32) -> i32 {
    if n <= 2 {
        return 1;
    }
    fib(n-2) + fib(n-1)
}

#[cfg(test)]
mod test {
    #[test]
    fn test_fib() {
        assert_eq!(
            vec![1, 1, 2, 3, 5, 8, 13, 21, 34, 55],
            (1..=10).map(super::fib).collect::<Vec<_>>()
        )
    }
}

/// Computes the n-th Fibonacci number.
#[pyfunction]
#[pyo3(name="fib")]
fn py_fib(n: i32) -> PyResult<i32> {
    Ok(fib(n))
}

/// Module containing high-performance utility functions written in Rust.
#[pymodule]
fn compute(_py: Python<'_>, m: &PyModule) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(py_fib, m)?)?;
    Ok(())
}
