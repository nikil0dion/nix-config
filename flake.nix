{
  description = "My NixOS configuration";

  inputs = {
    # NixOS defaults
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    systems.url = "github:nix-systems/default-linux";
    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    # Home configurations
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # SSH secrets app
    aginix.url = "github:ryantm/agenix";
    aginix.inputs.nixpkgs.follows = "nixpkgs";

    # Hyperland
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
       system = "x86_64-linux";
       host = "nix";
       username = "nixos";
        in {
          nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
               specialArgs = {
                 inherit system;
                 inherit inputs;
                 inherit username;
                 inherit host;
                };
               modules = [
               ./configuration.nix
               home-manager.nixosModules.home-manager {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.nixos = import ./home/home.nix;
       }
     ];
   };
 };
}

