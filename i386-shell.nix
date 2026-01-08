let
	pkgs = import <nixpkgs> {};
	crossEnv = pkgs.pkgsCross.gnu32;
in
crossEnv.mkShell {
	packages = with crossEnv; [
		gdb
		valgrind
		clangStdenv
		clang
	];
}
