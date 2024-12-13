{ config, pkgs, ...}:

{ 
  imports = [
      ./hardware-configuration.nix
      ./packages.nix
      ./linux-kernel.nix
      ./display-manager.nix
    ];


 # rtkit is optional but recommended
 security.rtkit.enable = true;

 # Env defaults
 environment.sessionVariables = {
   NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
   NIXOS_OZONE_WL = "1";
   WLR_NO_HARDWARE_CURSORS = "1";
   XDG_CACHE_HOME = "$HOME/.cache";   
   XDG_CONFIG_HOME = "$HOME/.config";
   XDG_DATA_HOME = "$HOME/.local/share";
   XDG_STATE_HOME = "$HOME/.local/state";
   XDG_CURRENT_DESKTOP = "Hyprland";
   XDG_SESSION_DESKTOP = "Hyprland";
   XDG_SESSION_TYPE = "wayland";
};

 # Audio service 
 services.pipewire = {
    enable = true;

    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

 # Your hostname
 networking.hostName = "nix";

 # Enable networking 
 networking.networkmanager.enable = true;

 # Disable ipv6 
 networking.ipv6 = false;

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

 # Steam enable 
 programs.steam = {
   enable = true;
   remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
   dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
   localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
 };

 
 # Enable nix Flakes
 nix.settings.experimental-features = [ "nix-command" "flakes" ]
 
 # Hyperland enable
 programs.hyprland.enable = true;
 programs.hyprland.xwayland.enable = true;

 # Enable Bluethooth
 hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;

 # Shell Fish
 programs.defaultUserShell = pkgs.fish;
 programs.fish.enable = true;

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
