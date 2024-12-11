{ config, pkgs, ...}:

{ 
  imports = [
      ./hardware-configuration.nix
      ./packages.nix
    ];

 # Enable Audio
 hardware.pulseaudio.enable = false;
 sound.enable = true;

 # rtkit is optional but recommended
 security.rtkit.enable = true;

 # Env defaults
 environment.variables = {
   NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
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
 hyperland.enable = true;

 # Disable IPV6
 enableIPv6 = false;

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

# System version 
 system.stateVersion = "24.11";
}
