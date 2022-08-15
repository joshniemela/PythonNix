{
  description = "Python direnv";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    mach-nix = {
      url = "github:DavHau/mach-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    mach-nix,
  }: let
    system = "x86_64-linux";
    python = "python310Full";
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
    };
    mach-nix-wrapper = import mach-nix {inherit pkgs python;};
    requirements = builtins.readFile ./requirements.txt;
    pythonBuild = mach-nix-wrapper.mkPython {inherit requirements;};
  in {
    packages.${system}.venv = pythonBuild;
    devShell.${system} = pkgs.mkShell {
      buildInputs = [
        pythonBuild
      ];
    };
  };
}