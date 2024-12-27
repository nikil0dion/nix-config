{
  description = "My NixOS configuration";

  inputs = {
    # NixOS defaults
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    systems.url = "github:nix-systems/default-linux";
    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    nixgl.url = "github:nix-community/nixGL";

    # Home configurations
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # SSH secrets app
    aginix.url = "github:ryantm/agenix";
    aginix.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
      };
    # Wezterm
    wezterm.url = "github:wez/wezterm?dir=nix";

  };

  outputs = { self, nixpkgs, home-manager, ... } : 
      let
        system = "x86_64-linux";
        host = "nixos";
        username = "nixos";
        in 
         {
           nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
               specialArgs = { inherit system username host; };
               modules = [
               ./configuration.nix 
               home-manager.nixosModules.home-manager {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.nixos = import ./home.nix;
         }
       ];
     };
   };
}
