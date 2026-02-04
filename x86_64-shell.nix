let
	pkgs = import <nixpkgs> {};
	crossEnv = pkgs.pkgsCross.gnu64;
in
crossEnv.mkShell {
	buildInputs = with crossEnv; [
		binutils
		gcc
	];
	nativeBuildInputs = with crossEnv; [
		cmake
		gnumake
		objconv
	];
}
