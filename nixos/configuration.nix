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

 # Network Time server 
 networking.timeServers = [ "pool.ntp.org" ];

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

   # Realtime Policy and Watchdog Daemon
   security.rtkit.enable = true;

   # Polkit enable
   security.polkit.enable = true;

   # Hyperlock screen 
   security.pam.services.hyprlock = { };

  #services.xserver.videoDrivers = [ "amdgpu" ];

  # OpenGL
  hardware.opengl = {
    enable = true;  # Enable OpenGL
    driSupport = true;  # Enable DRI (Direct Rendering Infrastructure)
    driSupport32Bit = true;  # Enable 32-bit DRI support for compatibility
  };

# Vulkan support
  hardware.vulkan = {
    enable = true;
    drivers = [ "amdvlk" ];  # Use AMD's Vulkan driver
  };

# System version 
 system.stateVersion = "24.11";
}
