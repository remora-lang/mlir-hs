let pkgs = import <nixpkgs> {};
    oldPkgs = import
      (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/21.05.tar.gz";
        sha256 = "1ckzhh24mgz6jd1xhfgx0i9mijk6xjqxwsshnvq789xsavrmsc36";
      }) {};
    ghc = oldPkgs.haskell.compiler.ghc8104;
    llvm = pkgs.llvmPackages_21;
in 
with pkgs;
stdenv.mkDerivation {
  name = "mlir-hs";
  buildInputs = [ghc llvm.mlir llvm.llvm];

  STACK_IN_NIX_EXTRA_ARGS 
    = " --extra-lib-dirs=${llvm.mlir}/lib"
    + " --extra-lib-dirs=${llvm.llvm}/lib"
    + " --extra-include-dirs=${llvm.mlir}/include"
    + " --extra-include-dirs=${llvm.llvm}/include";
}
