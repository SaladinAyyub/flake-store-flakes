{
  description = "Unreal Engine + VSCode IntelliSense environment on NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "ue-vscode";

          buildInputs = [
            pkgs.clang
            pkgs.lld
            pkgs.linuxHeaders
            pkgs.glibc.dev
          ];

          shellHook = ''
            echo "🔧 Setting up Unreal + VSCode dev env"

            # Ensure glibc + kernel headers are visible
            export CPATH="${pkgs.glibc.dev}/include:${pkgs.linuxHeaders}/include:$CPATH"

            # Show includes so you can confirm
            echo "CPATH includes:"
            echo "$CPATH" | tr ':' '\n'
          '';
        };
      }
    );
}
