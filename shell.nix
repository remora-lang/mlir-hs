let pkgs = import <nixpkgs> {};
    oldPkgs = import
      (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/21.05.tar.gz";
        sha256 = "1ckzhh24mgz6jd1xhfgx0i9mijk6xjqxwsshnvq789xsavrmsc36";
      }) {};
    ghc = oldPkgs.haskell.compiler.ghc8104;
    llvmpkgs = pkgs.llvmPackages_21;
    llvm = llvmpkgs.llvm.dev;
    mlir = llvmpkgs.mlir.dev;
in
with pkgs;
stdenv.mkDerivation {
  name = "mlir-hs";
  buildInputs = [ghc mlir llvm];

  MLIR_INCLUDE = "${mlir}/include";

  STACK_IN_NIX_EXTRA_ARGS
    = " --extra-lib-dirs=${mlir}/lib"
    + " --extra-lib-dirs=${llvm}/lib"
    + " --extra-include-dirs=${mlir}/include"
    + " --extra-include-dirs=${llvm}/include";
}
