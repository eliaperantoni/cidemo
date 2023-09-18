default:
    just --list

poetry_setup:
    cd py && poetry install

py_main: poetry_setup
    cd py && poetry run python main.py

py_test: poetry_setup
    cd py && poetry run pytest -v

rs_main:
    cd rs && cargo run

rs_test:
    cd rs && cargo test

test: py_test rs_test
