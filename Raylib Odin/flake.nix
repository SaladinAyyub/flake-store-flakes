{
  description = "Raylib Odin Project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    inputs.utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        xorgLibs = with pkgs.xorg; [
          libX11
          libX11.dev
        ];
      in
      {
        # `nix develop`
        devShells.default =
          with pkgs;
          mkShell {
            buildInputs = [
              libGL
              libGL.dev
              alsa-lib
            ] ++ xorgLibs;

            shellHook = ''
              export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${
                lib.makeLibraryPath (
                  with pkgs;
                  [
                    libGL
                    libGL.dev
                    alsa-lib
                  ]
                  ++ xorgLibs
                )
              }
            '';
          };
      }
    );
}
