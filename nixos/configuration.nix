# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
  # Единый список unfree — используется и системным nixpkgs, и unstable-инстансом
  allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "google-chrome"
      "zoom"
      "warp-terminal"
      "claude-code"
      "tradingview"
      "terraform"
      "vault"
    ];
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./linux-kernel.nix
      <home-manager/nixos>  # Home Manager module
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
	loader = {
		systemd-boot.enable = true;     # modern efi bootloader
			systemd-boot.configurationLimit = 10; # keep last 10 entries, auto-prune /boot
  		efi.canTouchEfiVariables = true; # allow efi modifications
  		};
		extraModprobeConfig = ''
			options iwlwifi power_save=0 disable_11ax=1
		'';
	};
  # Set your time zone and language 
  time.timeZone = "Europe/Madrid";          # timezone setting
  i18n.defaultLocale = "en_US.UTF-8";      # system language
  console.keyMap = "us";                   # console keyboard layout

  # Allow only these specific unfree packages (no blanket allowUnfree)
  nixpkgs.config.allowUnfreePredicate = allowUnfreePredicate;

  # База системы остаётся на 26.05. Из nixos-unstable тянем только точечно —
  # там, где отставание stable-канала реально мешает.
  # Требует: sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixos-unstable
  nixpkgs.overlays = [
    (final: prev:
      let
        unstable = import <nixos-unstable> {
          inherit (prev.stdenv.hostPlatform) system;
          config = { inherit allowUnfreePredicate; };  # отдельный инстанс — свой config
        };
      in
      {
        inherit unstable;  # pkgs.unstable.<name> — для разовых проб, без правки списков

        # Подмена атрибутов: в home.nix имена остаются прежними.
        inherit (unstable)
          warp-terminal   # 26.05 застрял на 0.2026.04.15, паника в RowIterator
          claude-code;    # релизы почти ежедневно
      })
  ];

  ## Networking   
  networking = {
	hostName = "www";                    # system hostname
	firewall.enable = false;             # disabled firewall (security risk! но нужно для docker)
  	networkmanager = {
  		enable = true;                   # network connection manager
		plugins = with pkgs; [	];
	};
   }; 
 
  ## Users
  users = {
    users.nikilodion = {
      isNormalUser = true;                    # regular user account
      home = "/home/nikilodion";
      group = "nikilodion";
      extraGroups = [ 
        "networkmanager"  # network settings
        "docker"          # docker access
        "plugdev"         # usb devices (ledger, etc)
        "video"           # video devices
        "audio"           # audio devices
      ];
    };
    groups.nikilodion = {};                   # user's primary group
  };

  # Home Manager configuration
  home-manager = {
    useGlobalPkgs = true;      # use system pkgs
    useUserPackages = true;    # install to /etc/profiles
    users.nikilodion = import ./home.nix;  # your home.nix
  };
  
  virtualisation = {
	docker = {                           # container platform
		enable = true;
 		storageDriver = "btrfs";         # use btrfs for containers
		daemon.settings = {
			# Network and security
			"ipv6" = false;              # disable IPv6
			"ip-forward" = true;        # don't forward IP packets
			"iptables" = true;           # use iptables rules
			"ip-masq" = true;           # disable IP masquerading
			"dns" = [ "1.1.1.1" "8.8.8.8" ]; # enable globaldns 
			
			# Security
			"live-restore" = true;       # keep containers running during restart
			"userland-proxy" = false;    # disable userland proxy for security
			"no-new-privileges" = true;  # prevent privilege escalation
			"icc" = false;               # disable inter-container communication
			
			# Performance
			"max-concurrent-downloads" = 3;  # limit concurrent downloads
			"max-concurrent-uploads" = 3;    # limit concurrent uploads
			"max-download-attempts" = 3;     # download retry attempts
			"shutdown-timeout" = 15;         # container shutdown timeout
			};
		};
  };

  # Enable services in system.
  services = { 
	displayManager = { 
	#	gdm.wayland = true;   # use wayland in gdm
        	gdm.enable = true;   # gnome display manager
		};
        desktopManager.gnome.enable = true; # gnome desktop

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
	libinput = {                 # touchscreen/touchpad support
		enable = true;
		touchpad = {
			tapping = true;
			naturalScrolling = true;
			disableWhileTyping = true;
			};
		};
	};
  

  # Fonts   
  fonts.packages = with pkgs; [
 	   jetbrains-mono          # programming font
	   noto-fonts-color-emoji	
  ];

   # Enable bluthooth 
  hardware = {
	bluetooth = {              # bluetooth support
		enable = true; 
  		powerOnBoot = true;
  		package = pkgs.bluez; 
		};
	ledger.enable = true;      # ledger hardware wallet support
  };  

  # Default programs 
  programs = {
	firefox.enable = true;     # web browser
  	dconf.enable = true;       # gnome configuration
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
environment.systemPackages = with pkgs; [
 	 # Development & Version Control
 	 git                      # version control system  
 	 # System Utilities
 	 e2fsprogs                # ext2/3/4 filesystem utilities
 	 fd                       # fast alternative to find
 	 lsof                     # list open files
 	 pciutils                 # PCI utilities (lspci)
 	 traceroute               # network diagnostic tool
 	 util-linux               # essential system utilities
	 iw                       # wifi tools
  
 	 # Monitoring & Hardware
 	 lm_sensors               # hardware monitoring (temp, fans)
  	 gnome-system-monitor     # system resource monitor
 	 undervolt                # CPU undervolting tool
 	 libinput                 # input device tools (touchscreen, touchpad)
  	 htop 

 	 # Networking & VPN
 	 iptables                 # firewall utilities
 	 openvpn                  # OpenVPN client
  
 	 # Proxy & Tunneling
 	 wireguard-tools          # WireGuard VPN
  
	# GNOME Desktop
 	 gnome-keyring            # credential storage
 	 gnome-terminal           # terminal emulator
  
 	 # Filesystem Support
 	 ntfs3g                   # NTFS filesystem support
 	 woeusb                   # Windows USB creator
  
  	 # Security & Crypto
  	 openssl                  # SSL/TLS toolkit
  
  	 # Graphics & Vulkan
 	 hwdata                   # hardware identification database  
	];

  # Secirity tools  
  security = {
	rtkit.enable = true;       # realtime kit
  	polkit.enable = true;      # privilege escalation
	};

  system.stateVersion = "26.05";

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

  # Disabling inactive services 
  systemd.services = {
    NetworkManager-wait-online.enable = false;  # skip network wait
    systemd-networkd-wait-online.enable = false; # skip networkd wait
    NetworkManager-dispatcher.enable = false;  # disable script dispatcher  
  };
	
 # Hardening for unsafe services
 systemd.services.thermald.serviceConfig = {
	ProtectHome = true;              # no access to /home
	PrivateTmp = true;               # isolated /tmp
	NoNewPrivileges = true;          # no privilege escalation
	};  
	
  # System logs cleanup
  services.journald = {
    extraConfig = ''
      SystemMaxUse=100M
      SystemMaxFileSize=50M
      MaxRetentionSec=1month
      RuntimeMaxUse=50M
      RuntimeMaxFileSize=25M
    '';
    rateLimitInterval = "30s";
    rateLimitBurst = 10000;
  };

}
