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

frontend_setup:
    cd frontend && bun install
frontend_dist: frontend_setup
    cd frontend && bun build --minify --outfile=dist/bundle.js src/index.tsx
frontend_dev: frontend_setup
    (cd frontend && bun build --watch --outfile=dist/bundle.js src/index.tsx) & python3 -m http.server 8081 -d frontend/dist & open "http://localhost:8081"
frontend_install: frontend_setup frontend_dist
    rm -rf server/lib/frontend
    cp -r frontend/dist server/lib/frontend

server_setup:
    cd server && poetry install
server_main: server_setup compute_install frontend_install
    cd server && poetry run python -m server
server_test: server_setup compute_install
    cd server && poetry run pytest -v
server_dist: server_setup compute_install
    cd server && poetry build -f wheel
