{  
  description = "My nixos configuration";

  inputs = { 
      # NixOS defaults 
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
      systems.url = "github:nix-systems/default-linux";
      hardware.url = "github:nixos/nixos-hardware";
      disco.url = "github:nix-community/disco";
      disco.inputs.nixpkgs.follows = "nixpkgs";
      impermanence.url = "github:nix-community/impormanence";

      # Home configurations
      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

      # Secureboot
      lanzabote.url = "github:nix-community/lanzabote/v0.4.1";
      lanzabote.inputs.nixpkgs.follows = "nixpkgs";

      # User Theme
      catppuccin.url = "github:catppuccin/nix";

      # SSH secrets app
      aginix.url = "github:ryantm/agenix";
      aginix.inputs.nixpkgs.follows = "nixpkgs";

      # Hyperland
      hyperland.url = "git+https://github.com/hyprwm/Hyperland?submodules=1";
   }

 outputs = {self, nixpkgs, home-manager, ... }@inputs: 
   let
      user = "nix"
      linuxSystems = [ "x86_64-linux" ];
      modules = [ 
         ./configuration.nix
         ];
   }      
    
