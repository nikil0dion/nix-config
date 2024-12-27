{ config, pkgs, ...}: {

  imports = [
    ./programs
  ];

  home = {
      username = "nixos";
      homeDirectory = "/home/nixos";
      stateVersion = "24.11";
      sessionVariables = {
          EDITOR = "nano";
          BROWSER = "firefox";
          NIXOS_OZONE_WL = "1";
          TERMINAL = "wezterm";
      };
      packages = with pkgs; [
          # Desktop apps
          firefox
          firefox-esr
          telegram-desktop
          brave
          rofi
          wofi
          vlc
          gparted
          obsidian
          handbrake

          # Coding stuff
          go
          vscodium

          # CLI utils
          lsd
          neofetch
          file
          tree
          wget
          git
          fastfetch
          htop
          nix-index
          unzip
          scrot
          ffmpeg
          light
          lux
          mediainfo
          ranger
          zram-generator
          cava
          zip
          brightnessctl
          swww
          openssl
          lazygit
          bluez
          bluez-tools
          docker
          kubectl

          # GUI utils
          feh
          imv
          dmenu
          screenkey
          mako
          gromit-mpx
          httpie

          # Wayland stuff
          xwayland
          wl-clipboard
          cliphist
      
          # WMs and stuff
          herbstluftwm
          hyprland
          seatd
          xdg-desktop-portal-hyprland
          polybar
          waybar
          pyprland
          hyprpicker
          hyprcursor
          hyprlock
          hypridle

          # Sound
          pipewire

          # Screenshotting
          grim
          grimblast
          slurp
          flameshot
          swappy

          # Other
          home-manager
          spice-vdagent
          tokyo-night-gtk
          xray
          nekoray
        ];


  programs.bash = {
    enable = true;
    shellAliases = {
      k = "kubectl";
      s = "systemctl";
      dc = "docker compose";
      d = "docker";
      df = "df -hT";
      dush = "du -shm | sort -rh";
      ls = "lsd --color=auto";
      la = "lsd -a"; # Hidden files
      lx = "lsd -lXh"; # Sort by extension
      lk = "lsd -lSrh"; # Sort by size
      lr = "lsd -lRh"; # Recursive ls
      lt = "lsd -ltrh"; # Sort by date
      cpr = "cp -r";
      mvr = "mv -r";
      [".."] = "cd ../"; 
      ["..."] = "cd ../../";
      ["...."] = "cd ../../../";
      jctl = "journalctl -p 3 -xb";
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      sst = "ss -tulpn";
      lsf = "lsof -i -P";
      ping = "ping -c 10";
    };
    bashrcExtra = ''
      . ~/.bashrc
    '';
  };
 
  programs.wezterm.enable = true;
  
  

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-BL";
    };
  };
}
