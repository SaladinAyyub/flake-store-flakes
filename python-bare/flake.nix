{
  description = "A bare(empty) template flake for Python Projects, edit shell.nix to add packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      devShells."x86_64-linux".default = import ./shell.nix { inherit pkgs; };
    };

}
