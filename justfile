default:
    just --list

clean:
    git clean -fdx

compute_test:
    cd compute && cargo test
compute_dist:
    cd compute && cargo build
compute_install: compute_dist
    cp compute/target/debug/libcompute.dylib server/lib/compute.so

poetry_setup:
    cd server && poetry install
server_main: poetry_setup compute_install
    cd server && poetry run python -m server
server_test: poetry_setup compute_install
    cd server && poetry run pytest -v
server_dist: poetry_setup compute_install
    cd server && poetry build -f wheel
