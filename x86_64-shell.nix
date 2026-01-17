let
	pkgs = import <nixpkgs> {};
	crossEnv = pkgs.pkgsCross.gnu64;
in
crossEnv.mkShell {
	buildInputs = with crossEnv; [
		valgrind
		binutils
		gcc
	];
	nativeBuildInputs = with crossEnv; [
		gdb
		cmake
		gnumake
		zsh
	];
}
