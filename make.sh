BASE_DIR=${PWD}
git submodule update --init --recursive

cd ./geth_bindings
rm go.sum
go get -u
make static_external

cd ${BASE_DIR}
rm -rf dep
mkdir -p dep
cd celo-bls-go/celo-bls-snark-rs/crates/bls-snark-sys
git checkout Cargo.toml
sed -i 's/staticlib/staticlib", "dylib/g' Cargo.toml
cargo build --release
cd  ${BASE_DIR}
cp celo-bls-go/celo-bls-snark-rs/target/release/libbls_snark_sys.so dep

cd ${BASE_DIR}/celo_bindings
rm go.sum
go get -u
make static_external
