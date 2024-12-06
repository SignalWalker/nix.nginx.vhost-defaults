{
  description = "A NixOS module for easily blocking user agents from Nginx.";
  inputs = {
    ai-robots-txt = {
      url = "github:ai-robots-txt/ai.robots.txt";
      flake = false;
    };
  };
  outputs = {self, ...}: {
    nixosModules.default = import ./nixos-module.nix {inherit self;};
  };
}
