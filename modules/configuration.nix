{ config, pkgs, ...}:

{ 
  imports = [
      ./hardware-configuration.nix
      ./packages.nix
    ];

 # Bootloader 
 boot.loader.systemd-boot.enable = true;
 boot.loader.efi.canTouchEfiVariables = true;

 # Your hostname
 networking.hostName = "nix";

 # Enable networking 
 networking.networkmanager.enable = true;

 # Set time zone
 time.timeZone = "UTC";

 # Select internationalisation propertis
 i18n.defaultLocale = "en_US.UTF-8";

 # Define a user accout 
 users.user.nix = { 
    isNormalUser = true; 
    description = "nix";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = import ./packages.nix;
};

 # Enable nix Flakes
 nix.settings.experimental-features = [ "nix-command" "flakes" ]
 
 # Hyperland enable
 hyperland.enable = true;

 # Disable IPV6
 enableIPv6 = false;

 # System version 
 system.stateVersion = "24.11";
}
