default:
    just --list

poetry_setup:
    cd py && poetry install

clean:
    git clean -fdx

prepare_dist:
    mkdir -p ./dist

py_main: poetry_setup
    cd py && poetry run python cidemo/main.py

py_test: poetry_setup
    cd py && poetry run pytest -v tests/*

py_dist: prepare_dist
    cd py && poetry build -f wheel
    cp py/dist/*.whl dist/cidemo_py.whl

rs_main:
    cd rs && cargo run

rs_test:
    cd rs && cargo test

rs_dist: prepare_dist
    cd rs && cargo build --release
    cp rs/target/release/cidemo dist/cidemo_rs.bin

test: py_test rs_test

dist: py_dist rs_dist
