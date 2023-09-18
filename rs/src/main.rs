fn fib(n: i32) -> i32 {
    if n <= 2 {
        1
    } else {
        fib(n-2) + fib(n-1)
    }
}

fn main() {
    println!("{}", fib(5));
}

#[cfg(test)]
mod test {
    #[test]
    fn test_fib() {
        assert_eq!(
            vec!(1, 1, 2, 3, 5, 8, 13, 21, 34, 55),
            (1..=10).map(super::fib).collect::<Vec<_>>()
        );
    }
}
