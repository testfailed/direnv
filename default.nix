{ pkgs ? import ./nix { } }:
with pkgs;

buildGoModule rec {
  name = "direnv-${version}";
  version = lib.fileContents ./version.txt;
  subPackages = [ "." ];

  vendorSha256 = "0iap1iivf8ll1xdcc31hmfi5fxfqvyp83a7pkhhjw055mda5k7a0";

  src = lib.cleanSource ./.;

  # we have no bash at the moment for windows
  makeFlags = lib.optional (!stdenv.hostPlatform.isWindows) [
    "BASH_PATH=${bash}/bin/bash"
  ];

  installPhase = ''
    make install PREFIX=$out
  '';

  meta = {
    description = "A shell extension that manages your environment";
    homepage = https://direnv.net;
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ zimbatm ];
  };
}
