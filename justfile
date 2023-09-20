default:
    just --list

clean:
    git clean -fdx

build_compute:
    cd compute && cargo build --release
build_frontend:
    cd frontend && bun install && bun build --minify --outfile=dist/bundle.js index.tsx && cp public/* dist/

install_compute:
    cp compute/target/release/libcompute.dylib server/lib/compute.so
install_frontend:
    rm -rf server/lib/frontend
    cp -r frontend/dist server/lib/frontend

run:
    cd server && poetry run python -m server
test:
    cd server && just run &
    -cd test && URL="http://localhost:8080" bun test
    kill `lsof -t -i tcp:8080`
make_wheel:
    cd server && poetry build -f wheel
