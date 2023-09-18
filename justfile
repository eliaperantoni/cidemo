default:
    just --list

clean:
    git clean -fdx

# Rust
rs_test:
    cd rs && cargo test
rs_dist:
    cd rs && cargo build
rs_install: rs_dist
    cp rs/target/debug/libcidemo_rs.dylib py/lib/cidemo_rs.so

# Python
poetry_setup:
    cd py && poetry install
py_main: poetry_setup rs_install
    cd py && poetry run python cidemo_py/main.py
py_test: poetry_setup rs_install
    cd py && poetry run pytest -v
py_dist: poetry_setup rs_install
    cd py && poetry build -f wheel
