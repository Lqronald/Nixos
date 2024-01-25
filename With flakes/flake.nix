# /etc/nixos/flake.nix
{
  description = "flake for nixpc";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
   # home-manager.url = "github:nix-community/home-manager";
   # home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = {
      nixpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}

