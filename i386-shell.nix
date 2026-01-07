let pkgs = import <nixpkgs> {}; in
pkgs.pkgsCross.gnu32.mkShell {}
