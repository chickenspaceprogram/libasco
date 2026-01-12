let
	pkgs = import <nixpkgs> {};
	crossEnv = pkgs.pkgsCross.gnu64;
in
crossEnv.mkShell {
	buildInputs = with crossEnv; [
#		llvmPackages.compiler-rt
		gdb
		valgrind
	];
}
