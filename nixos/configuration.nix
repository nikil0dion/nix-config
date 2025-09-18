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
		systemd-boot.enable = true;
  		efi.canTouchEfiVariables = true;
  		};
	};
  # Set your time zone and language 
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  ## Networking   
  networking = {
	hostName = "www";
	firewall.enable = false;
  	networkmanager.enable = true;
	networkmanager.plugins = [ ];
        #useNetworkd = true;
  	#useDHCP = false;
 	#interfaces.wlp2s0.useDHCP = true;  # if your use Wi-Fi
  	#interfaces.eth0.useDHCP = true;   # if your use Ethernet
   }; 
 
  ## Containerization and virtualization
  users = { 
	extraGroups = {
		vboxusers.members = [ "nikilodion" ];
		docker.members = [ "nikilodion" ];
		};
  };
  virtualisation = {
	virtualbox = {
		host.enable = true;
  		guest.enable = false;
  		guest.dragAndDrop = false;
 		};
	docker = {
		enable = true;
 		storageDriver = "btrfs";
 		};
  };

  # Enable services in system.
  services = { 
	xserver = {
        	enable = true;
		displayManager.gdm.wayland = true;
                displayManager.gdm.enable = true;
                desktopManager.gnome.enable = true;
 		xkb.layout = "us";
		};
	gnome = {
		localsearch.enable = false;
		tinysparql.enable = false;
		core-apps.enable = false;
		core-developer-tools.enable = false;
		games.enable = false;
   		sushi.enable = true;
		};
        avahi = { 
		enable = false;
 		};
	pipewire = {
		enable = true;
     		alsa.enable = true;
     		jack.enable = true;
     		pulse.enable = true;
		};
	httpd = {
		enable = false;
		};
	thermald = {
		enable = true;  
		};
	irqbalance = { 
		enable = true; 
		};
  };	

#services.undervolt = {
#  enable = true;
 # coreOffset = -80;  # Начальное значение, можно увеличить
 # cacheOffset = -80;
 # gpuOffset = -50;
 # temperature = 80;  # Снижена для лучшего охлаждения
 # turbo = 1;  # Включить turbo boost
#};

  # Fonts   
  fonts.packages = with pkgs; [
 	   jetbrains-mono
  ];

   # Enable bluthooth 
  hardware = {
	bluetooth = {
		enable = true; 
  		powerOnBoot = true;
  		package = pkgs.bluez; 
		};
  };  

  # Default programs 
  programs = {
	firefox.enable = true;
  	dconf.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     git
     nekoray
     lact
     stress
     lm_sensors
     undervolt
  ];
  
  security = {
	rtkit.enable = true;
  	polkit.enable = true;
	};

  system.stateVersion = "25.05";

  systemd.services = {
    NetworkManager-wait-online.enable = false;
    systemd-networkd-wait-online.enable = false;
  };

}
