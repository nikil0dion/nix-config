{ config, pkgs, ...}:

{ 
  imports = [
      ./hardware-configuration.nix
      ./linux-kernel.nix
    ];

 # Your hostname
 networking.hostName = "nix";

 # Enable networking 
 networking.networkmanager.enable = true;

 # Set time zonenanop
 time.timeZone = "UTC";

 # Select internationalisation propertis
 i18n.defaultLocale = "en_US.UTF-8";

# Define a user accout 
 users.user.nixos = { 
    isNormalUser = true; 
    description = "nix";
    extraGroups = [ "networkmanager" ];
};fp

 # Enable nix Flakes
 nix.settings.experimental-features = [ "nix-command" "flakes" ]

 # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    noto-fonts-color-emoji
  ];
}

# System version 
 system.stateVersion = "24.11";
}
