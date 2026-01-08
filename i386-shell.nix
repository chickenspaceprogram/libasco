let
	pkgs = import <nixpkgs> {};
	crossEnv = pkgs.pkgsCross.gnu32;
in
crossEnv.mkShell {
	buildInputs = with crossEnv; [
		llvmPackages.compiler-rt
		gdb
		valgrind
		clang
		clangStdenv
		clang-tools
	];
}
