let
	pkgs = (import <nixpkgs> {}).pkgsCross.gnu64;
in

pkgs.callPackage({ mkShell, cmakeMinimal, gdb }: mkShell {
	nativeBuildInputs = [ cmakeMinimal ];
	packages = [ gdb ];
	buildInputs = [
	];
}) {}
