{ config, pkgs, ...}: {

  imports = [ ];

  home = {
      username = "nixos";
      homeDirectory = "/home/nixos";
      stateVersion = "24.11";
      sessionVariables = {
          EDITOR = "nano";
          BROWSER = "firefox";
          NIXOS_OZONE_WL = "1";
          TERMINAL = "wezterm";
          XDG_SESSION_TYPE = "wayland";
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

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig =
      let
        modifier = "SUPER";
      in
      concatStrings [
        ''
          env = NIXOS_OZONE_WL, 1
          env = NIXPKGS_ALLOW_UNFREE, 1
          env = XDG_CURRENT_DESKTOP, Hyprland
          env = XDG_SESSION_TYPE, wayland
          env = XDG_SESSION_DESKTOP, Hyprland
          env = GDK_BACKEND, wayland, x11
          env = CLUTTER_BACKEND, wayland
          env = QT_QPA_PLATFORM=wayland;xcb
          env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
          env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
          env = SDL_VIDEODRIVER, x11
          env = MOZ_ENABLE_WAYLAND, 1
          exec-once = dbus-update-activation-environment --systemd --all
          exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          exec-once = killall -q swww;sleep .5 && swww init
          exec-once = killall -q waybar;sleep .5 && waybar
          exec-once = killall -q dunst;sleep .5 && dunst
          exec-once = nm-applet --indicator
          exec-once = lxqt-policykit-agent
          exec-once = sleep 1.5 && swww img /home/nixos/wallpapers/mountains-1.jpg
          monitor=,preferred,auto,1
          input {
            kb_layout = us,ru
            kb_options = grp:win_space_toggle
            follow_mouse = 1
            sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
            accel_profile = flat
          }
          windowrule = noborder,^(wofi)$
          windowrule = center,^(wofi)$
          windowrule = center,^(steam)$
          windowrule = float, nm-connection-editor|blueman-manager
          windowrule = float, swayimg|vlc|Viewnior|pavucontrol
          windowrule = float, nwg-look|qt5ct|mpv
          windowrule = float, zoom
          windowrulev2 = stayfocused, title:^()$,class:^(steam)$
          windowrulev2 = minsize 1 1, title:^()$,class:^(steam)$
          windowrulev2 = opacity 0.9 0.7, class:^(firefox)$
          windowrulev2 = opacity 0.9 0.7, class:^(nautilus)$
          gestures {
            workspace_swipe = true
            workspace_swipe_fingers = 3
          }
          misc {
            initial_workspace_tracking = 0
            mouse_move_enables_dpms = true
            key_press_enables_dpms = false
          }
          animations {
            enabled = yes
            bezier = wind, 0.05, 0.9, 0.1, 1.05
            bezier = winIn, 0.1, 1.1, 0.1, 1.1
            bezier = winOut, 0.3, -0.3, 0, 1
            bezier = liner, 1, 1, 1, 1
            animation = windows, 1, 6, wind, slide
            animation = windowsIn, 1, 6, winIn, slide
            animation = windowsOut, 1, 5, winOut, slide
            animation = windowsMove, 1, 5, wind, slide
            animation = border, 1, 1, liner
            animation = fade, 1, 10, default
            animation = workspaces, 1, 5, wind
          }
          decoration {
            rounding = 10
            drop_shadow = true
            shadow_range = 4
            shadow_render_power = 3
            col.shadow = rgba(1a1a1aee)
            blur {
                enabled = true
                size = 5
                passes = 3
                new_optimizations = on
                ignore_opacity = off
            }
          }
          plugin {
            hyprtrails {
            }
          }
          dwindle {
            pseudotile = true
            preserve_split = true
          }

          bind = ${modifier},Return,exec,wezterm
          bind = ${modifier}SHIFT,Return,exec,rofi-launcher
          bind = ${modifier}SHIFT,W,exec,web-search
          bind = ${modifier}ALT,W,exec,wallsetter
          bind = ${modifier}SHIFT,N,exec,swaync-client -rs
          bind = ${modifier},W,exec,firefox
          bind = ${modifier},E,exec,emopicker9000
          bind = ${modifier},S,exec,screenshootin
          bind = ${modifier},D,exec,discord
          bind = ${modifier},O,exec,obs
          bind = ${modifier},C,exec,hyprpicker -a
          bind = ${modifier},G,exec,gimp
          bind = ${modifier}SHIFT,G,exec,godot4
          bind = ${modifier},T,exec,thunar
          bind = ${modifier},M,exec,spotify
          bind = ${modifier},Q,killactive,
          bind = ${modifier},P,pseudo,
          bind = ${modifier}SHIFT,I,togglesplit,
          bind = ${modifier},F,fullscreen,
          bind = ${modifier}SHIFT,F,togglefloating,
          bind = ${modifier}SHIFT,C,exit,
          bind = ${modifier}SHIFT,left,movewindow,l
          bind = ${modifier}SHIFT,right,movewindow,r
          bind = ${modifier}SHIFT,up,movewindow,u
          bind = ${modifier}SHIFT,down,movewindow,d
          bind = ${modifier}SHIFT,h,movewindow,l
          bind = ${modifier}SHIFT,l,movewindow,r
          bind = ${modifier}SHIFT,k,movewindow,u
          bind = ${modifier}SHIFT,j,movewindow,d
          bind = ${modifier},left,movefocus,l
          bind = ${modifier},right,movefocus,r
          bind = ${modifier},up,movefocus,u
          bind = ${modifier},down,movefocus,d
          bind = ${modifier},h,movefocus,l
          bind = ${modifier},l,movefocus,r
          bind = ${modifier},k,movefocus,u
          bind = ${modifier},j,movefocus,d
          bind = ${modifier},1,workspace,1
          bind = ${modifier},2,workspace,2
          bind = ${modifier},3,workspace,3
          bind = ${modifier},4,workspace,4
          bind = ${modifier},5,workspace,5
          bind = ${modifier},6,workspace,6
          bind = ${modifier},7,workspace,7
          bind = ${modifier},8,workspace,8
          bind = ${modifier},9,workspace,9
          bind = ${modifier},0,workspace,10
          bind = ${modifier}SHIFT,SPACE,movetoworkspace,special
          bind = ${modifier},SPACE,togglespecialworkspace
          bind = ${modifier}SHIFT,1,movetoworkspace,1
          bind = ${modifier}SHIFT,2,movetoworkspace,2
          bind = ${modifier}SHIFT,3,movetoworkspace,3
          bind = ${modifier}SHIFT,4,movetoworkspace,4
          bind = ${modifier}SHIFT,5,movetoworkspace,5
          bind = ${modifier}SHIFT,6,movetoworkspace,6
          bind = ${modifier}SHIFT,7,movetoworkspace,7
          bind = ${modifier}SHIFT,8,movetoworkspace,8
          bind = ${modifier}SHIFT,9,movetoworkspace,9
          bind = ${modifier}SHIFT,0,movetoworkspace,10
          bind = ${modifier}CONTROL,right,workspace,e+1
          bind = ${modifier}CONTROL,left,workspace,e-1
          bind = ${modifier},mouse_down,workspace, e+1
          bind = ${modifier},mouse_up,workspace, e-1
          bindm = ${modifier},mouse:272,movewindow
          bindm = ${modifier},mouse:273,resizewindow
          bind = ALT,Tab,cyclenext
          bind = ALT,Tab,bringactivetotop
          bind = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
          bind = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          binde = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
          bind = ,XF86AudioPlay, exec, playerctl play-pause
          bind = ,XF86AudioPause, exec, playerctl play-pause
          bind = ,XF86AudioNext, exec, playerctl next
          bind = ,XF86AudioPrev, exec, playerctl previous
          bind = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
          bind = ,XF86MonBrightnessUp,exec,brightnessctl set +5%
        ''
      ];
    };

  
  programs.dcof.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-BL";
    };
  };
}
