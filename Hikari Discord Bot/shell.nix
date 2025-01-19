{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.hikari
      python-pkgs.hikari-crescent
      python-pkgs.requests
      python-pkgs.uvloop
      python-pkgs.python-dotenv
    ]))
  ];
}
