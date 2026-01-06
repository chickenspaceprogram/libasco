let pkgs = import <nixpkgs> {}; in
pkgs.pkgsCross.armv7l-hf-multiplatform.mkShell {}
