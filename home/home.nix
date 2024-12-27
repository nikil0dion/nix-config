{ hyprland, pkgs, ...}: {

  imports = [
    hyprland.homeManagerModules.default
    ./programs
    ./scripts
    ./themes
  ];

 home-manager.users.nixos = {
  enable = true;

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
      [".."] = "cd ../"; # Special case for ".."
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

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-BL";
    };
  };

  home.stateVersion = "24.11";
}
