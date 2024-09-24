# Nginx Virtual Host Defaults

A small NixOS module adding the option `services.nginx.virtualHostDefaults`, which is a submodule merged into every virtual host configuration, allowing you to set options common to every Nginx virtual host.

It also adds `services.nginx.virtualHosts.<name>.blockAgents`, which allows you to easily block a a set of user agent strings from accessing a vhost.

## Usage Examples

`flake.nix`:
```nix
inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nginx-vhost-defaults = {
        url = "github:signalwalker/nix.nginx.vhost-defaults";
    };
};
outputs = inputs @ {
    self,
    nixpkgs,
    ...
}: {
    nixosConfigurations."example" = nixpkgs.lib.nixosSystem {
        # ...
        modules = [
            inputs.nginx-vhost-defaults.nixosModules.default
            ./nixos-module.nix
            # ...
        ];
    };
};
```

`nixos-module.nix`:
```nix
{
    config,
    pkgs,
    lib,
    ...
}: {
    config = {
        services.nginx = {
            virtualHostDefaults = {
                # force SSL on every virtual host
                forceSSL = true;
                # Block a set of user agents from accessing any virtual host.
                blockAgents = {
                    enable = true;
                    # Use `lib.mkOptionDefault` if you want to preserve the default agent list, which includes all agents found in https://github.com/ai-robots-txt/ai-robots-txt
                    agents = lib.mkOptionDefault ["SemrushBot"];
                    # This is the default, which causes Nginx to drop the connection without any response.
                    method = "return 444";
                };
            };
        };
    };
}
```

