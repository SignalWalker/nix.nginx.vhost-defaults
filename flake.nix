{
  description = "A NixOS module for easily blocking user agents from Nginx.";
  inputs = {
    alejandra = {
      url = "github:kamadorueda/alejandra";
    };
    ai-robots-txt = {
      url = "github:ai-robots-txt/ai.robots.txt";
      flake = false;
    };
  };
  outputs = inputs @ {self, ...}:
    with builtins; {
      formatter = std.mapAttrs (system: pkgs: pkgs.default) inputs.alejandra.packages;
      nixosModules.default = import ./nixos-module.nix {inherit self;};
    };
}
