{ config, pkgs, ...}: {

  imports = [ ];

  home = {
      username = "nixos";
      homeDirectory = "/home/nixos";
      stateVersion = "25.05";
      packages = with pkgs; [
		alsa-utils
		android-tools
		audacity
		bluez
		bottles-unwrapped
		clickhouse
		cursor
		d-spy
		dbeaver-bin
		dconf
		dconf-editor
		dive
		docker
		docker-compose
		drawio
		eog
		ffmpeg-full
		figma-linux
		file
		file-roller
		floorp
		gedit
		gimp
		gnome-terminal
		gnome-tweaks
		gnome-weather
		gnumake
		grpcurl
		gst-plugins-base
		gst-plugins-good
		gstreamer
		gtk+3
		hamster
		htop
		httpie-desktop
		iptables
		kdenlive
		keepassxc
		kubernetes
		lsd
		lsof
		lynis
		meld
		minikube
		minio-client
		nautilus
		neofetch-unstable
		ninja
		nmap
		nss-cacert
		obsidian
		pciutils
		postgresql
		sdkmanager
		sops
		sysstat
		telegram-desktop
		totem
		trivy
		unzip
		valkey
		vlc
		vulkan-tools
		warp-terminal
		wget
		zip
		zoom
      ];
  };
}
