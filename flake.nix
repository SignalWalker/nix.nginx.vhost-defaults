{
  description = "A NixOS module for easily blocking user agents from Nginx.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ai-robots-txt = {
      url = "github:ai-robots-txt/ai.robots.txt";
      flake = false;
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }:
    with builtins; let
      std = nixpkgs.lib;
    in {
      formatter = std.mapAttrs (system: pkgs: pkgs.default) inputs.alejandra.packages;
      nixosModules.default = import ./nixos-module.nix {inherit self;};
    };
}
