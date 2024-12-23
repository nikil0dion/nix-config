{ config, pkgs, ...}:

{ 
  imports = [
      ./hardware-configuration.nix
      ./packages.nix
      ./linux-kernel.nix
      ./security.nix
      ./programs.nix
      ./services.nix
    ];

 # Env defaults
 environment.sessionVariables = {
   NIXOS_OZONE_WL = "1";
   WLR_NO_HARDWARE_CURSORS = "1";
  # XDG_CACHE_HOME = "$HOME/.cache";   
  # XDG_CONFIG_HOME = "$HOME/.config";
  # XDG_DATA_HOME = "$HOME/.local/share";
  # XDG_STATE_HOME = "$HOME/.local/state";
  # XDG_CURRENT_DESKTOP = "Hyprland";
  # XDG_SESSION_DESKTOP = "Hyprland";
};

 # Your hostname
 networking.hostName = "nix";

 # Enable networking 
 networking.networkmanager.enable = true;

 # Set time zone
 time.timeZone = "UTC";

 # Select internationalisation propertis
 i18n.defaultLocale = "en_US.UTF-8";

# Define a user accout 
 users.user.nixos = { 
    isNormalUser = true; 
    description = "nix";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
       firefox
       telegram-desktop
       vscodium
  ];
};

 # Steam enable 
 programs.steam = {
   enable = true;
   remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
   dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
   localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
 };

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
