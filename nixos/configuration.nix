# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./linux-kernel.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
	loader = {
		systemd-boot.enable = true;     # modern efi bootloader
  		efi.canTouchEfiVariables = true; # allow efi modifications
  		};
	};
  # Set your time zone and language 
  time.timeZone = "Europe/Moscow";          # timezone setting
  i18n.defaultLocale = "en_US.UTF-8";      # system language
  console.keyMap = "us";                   # console keyboard layout

  ## Networking   
  networking = {
	hostName = "www";                    # system hostname
	firewall.enable = false;             # disabled firewall (security risk!)
  	networkmanager.enable = true;        # network connection manager
	networkmanager.plugins = [ ];
        #useNetworkd = true;
  	#useDHCP = false;
 	#interfaces.wlp2s0.useDHCP = true;  # if your use Wi-Fi
  	#interfaces.eth0.useDHCP = true;   # if your use Ethernet
   }; 
 
  ## Containerization and virtualization
  users = { 
	extraGroups = {
		vboxusers.members = [ "nikilodion" ]; # virtualbox access
		docker.members = [ "nikilodion" ];    # docker access
		};
  };
  virtualisation = {
	virtualbox = {                       # oracle virtualbox
		host.enable = true;
  		guest.enable = false;
  		guest.dragAndDrop = false;
 		};
	docker = {                           # container platform
		enable = true;
 		storageDriver = "btrfs";         # use btrfs for containers
 		};
  };

  # Enable services in system.
  services = { 
	xserver = {                          # x11 display server
        enable = true;
		displayManager.gdm.wayland = true;   # use wayland in gdm
        displayManager.gdm.enable = true;   # gnome display manager
        desktopManager.gnome.enable = true; # gnome desktop
 		xkb.layout = "us";               # keyboard layout
		};
	gnome = {                            # gnome desktop settings
		localsearch.enable = false;      # file indexing
		tinysparql.enable = false;       # metadata tracker
		core-apps.enable = false;        # default apps
		core-developer-tools.enable = false; # dev tools
		games.enable = false;            # gnome games
   		sushi.enable = true;             # file previewer
		};
        avahi = {                            # network service discovery
		enable = false;                  
 		};
	pipewire = {              # modern audio server
		enable = true;
     		alsa.enable = true;
     		jack.enable = true;
     		pulse.enable = true;
		};
	httpd = {                 # apache web server
		enable = false;
		};
	thermald = {              # thermal management daemon
		enable = true;  
		};
	irqbalance = {            # interrupt balancing
		enable = true; 
		};
	undervolt = {             # cpu undervolting service
		enable = true;
 		coreOffset = -20;
 		gpuOffset = -20;
        uncoreOffset = -20;
 		analogioOffset = -20;
		temp = 80;
	        turbo = 0;
		};
	fstrim = {                # ssd trim optimization
		enable = true;
		};
	btrfs = {                 # btrfs filesystem tools
		autoScrub = {
			enable = true;
			interval = "monthly";
			fileSystems = [ "/" ];
			};
		};
    };	

  # Fonts   
  fonts.packages = with pkgs; [
 	   jetbrains-mono          # programming font
  ];

   # Enable bluthooth 
  hardware = {
	bluetooth = {              # bluetooth support
		enable = true; 
  		powerOnBoot = true;
  		package = pkgs.bluez; 
		};
  };  

  # Default programs 
  programs = {
	firefox.enable = true;     # web browser
  	dconf.enable = true;       # gnome configuration
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     git                # version control system
     nekoray            # v2ray/xray gui client  
     lact               # gpu control and monitoring
     stress             # system stress testing
     lm_sensors         # hardware monitoring (temp, fans)
     undervolt          # cpu undervolting tool
     vulkan-headers     # vulkan api headers
     hwdata             # hardware identification database
  ];

  # Secirity tools  
  security = {
	rtkit.enable = true;       # realtime kit
  	polkit.enable = true;      # privilege escalation
	};

  system.stateVersion = "25.05";

  # Nix garbage collection and optimization
  nix = {
    settings = {
      auto-optimise-store = true;        # automatic store optimization
      experimental-features = [ "nix-command" ]; # modern nix cli
    };
    gc = {                               # garbage collection
      automatic = true;                  # enable automatic cleanup
      dates = "weekly";                  # run weekly
      options = "--delete-older-than 30d"; # keep last 30 days
    };
    optimise = {                         # store optimization
      automatic = true;                  # enable automatic optimization
      dates = [ "weekly" ];              # run weekly
    };
  };

  # Disabling inactive 
  systemd.services = {
    NetworkManager-wait-online.enable = false;  # skip network wait
    systemd-networkd-wait-online.enable = false; # skip networkd wait
  };
  
  # System logs cleanup
  services.journald.extraConfig = ''
    SystemMaxUse=100M                    # limit journal size to 100MB
    SystemMaxFileSize=50M                # max file size 50MB
    MaxRetentionSec=1month               # keep logs for 1 month
  '';
  
  # Gpu control 
  systemd.services.lact = {    # gpu monitoring daemon
    description = "GPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };


}
