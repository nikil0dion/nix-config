{ config, pkgs, ...}: {                                                                                                                                                         
                                                                                                                                                                                  
    imports = [ ];                                                                                                                                                                
                                                                                                                                                                                  
    home = {                                                                                                                                                                      
        stateVersion = "26.05";                                                                                                                                                   
                                                                                                                                                                                  
        sessionVariables = {                                                                                                                                                      
          MOZ_ENABLE_WAYLAND = "1";                                                                                                                                               
          GDK_BACKEND = "wayland";                                                                                                                                                
          QT_QPA_PLATFORM = "wayland";                                                                                                                                            
          CLUTTER_BACKEND = "wayland";                                                                                                                                            
          SDL_VIDEODRIVER = "wayland"; 
	  NIXOS_OZONE_WL = "1";       # Chrome/Electron/Warp/Figma native Wayland
                                                                                                                                           
        };                                                                                                                                                                        
                                                                                                                                                                                  
        packages = with pkgs; [                                                                                                                                                   
          # ═══════════════════════════════════════════                                                                                                                           
          # CLI Core                                                                                                                                                              
          # ═══════════════════════════════════════════                  
          ripgrep fd tree file wget unzip zip jq fx xh                                                                                                           
          rsync ouch exiftool                                                                                                                                                                          
          # ═══════════════════════════════════════════                                                                                                                           
          # System Monitoring                                                                                                                                                     
          # ═══════════════════════════════════════════                                                                                                                           
          htop btop bottom duf dust lsof sysstat pciutils                                                                                                                         
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Files & Text                                                                                                                                                          
          # ═══════════════════════════════════════════                                                                                                                           
          bat eza delta lnav trash-cli file-roller                                                                                                                                
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Git                                                                                                                                                                   
          # ═══════════════════════════════════════════                                                                                                                           
          lazygit meld gh                                                                                                                                                            
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Containers & K8s                                                                                                                                                      
          # ═══════════════════════════════════════════                                                                                                                           
          docker docker-compose dive lazydocker freelens-bin
          kubernetes k9s kubectx kubernetes-helm stern minikube     
          # ═══════════════════════════════════════════                                                                                                                           
          # IaC & Cloud                                                                                                                                                           
          # ═══════════════════════════════════════════                                                                                                                           
          terraform opentofu sops awscli google-cloud-sdk                                                                                                                           
          vault doctl terragrunt infracost
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Network & Security                                                                                                                                                    
          # ═══════════════════════════════════════════                                                                                                                           
          bind nmap iptables lynis subfinder trivy sshpass
          doggo dog trippy gping bandwhich websocat
          k6 oha vegeta cloudflared tailscale                
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Development                                                                                                                                                           
          # ═══════════════════════════════════════════                                                                                                                           
          golangci-lint grpcurl gnumake ninja amber-lang                                                                                                                          
          nodejs_24 bun python3Packages.cfn-lint                                                                                                                                                                               
          # ═══════════════════════════════════════════                                                                                                                           
          # Database                                                                                                                                                              
          # ═══════════════════════════════════════════                                                                                                                           
          postgresql dbeaver-bin valkey minio-client 
	  clickhouse
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Android                                                                                                                                                               
          # ═══════════════════════════════════════════                                                                                                                           
          android-tools sdkmanager                                                                                                                                                
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Media & Graphics                                                                                                                                                                
          # ═══════════════════════════════════════════                                                                                                                           
          ffmpeg-full audacity kdePackages.kdenlive gimp-with-plugins                                                                                                             
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # GNOME Desktop                                                                                                                                                         
          # ═══════════════════════════════════════════                                                                                                                           
          gnome-terminal gnome-tweaks gnome-calculator gnome-characters                                                                                                           
          gnome-disk-utility gnome-keyring gnome-weather                                                                                                                          
          nautilus eog evince totem gedit                                                                                                                                         
          dconf dconf-editor d-spy desktop-file-utils                                                                                                                             
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # GTK/Qt                                                                                                                                                                
          # ═══════════════════════════════════════════                                                                                                                           
          gtk3 gtk4                                                                                                                                                               
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Browsers                                                                                                                                                              
          # ═══════════════════════════════════════════                                                                                                                           
          floorp-bin google-chrome                                                                                                                                                
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Communication                                                                                                                                                         
          # ═══════════════════════════════════════════                                                                                                                           
          telegram-desktop zoom-us                                                                                                                                          
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Terminals & AI                                                                                                                                                        
          # ═══════════════════════════════════════════                                                                                                                           
          warp-terminal claude-code claude-monitor                                                                                                                                
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Productivity                                                                                                                                                          
          # ═══════════════════════════════════════════                                                                                                                           
          drawio figma-linux proton-pass tradingview                                                                                                            
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Virtualization                                                                                                                                                        
          # ═══════════════════════════════════════════                                                                                                                           
          quickemu bottles appimage-run                                                                                                                                           
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Remote                                                                                                                                                                
          # ═══════════════════════════════════════════                                                                                                                           
          remmina                                                                                                                                                                 
                                                                                                                                                                                  
          # ═══════════════════════════════════════════                                                                                                                           
          # Hardware & System                                                                                                                                                     
          # ═══════════════════════════════════════════                                                                                                                           
          bluez alsa-utils vulkan-tools ledger-live-desktop                                                                                                                       
          cacert noto-fonts-color-emoji unetbootin                                                                                                                                
        ];                                                                                                                                                                        
    };                                                                                                                                                                            
                                                                                                                                                                                  
    programs.home-manager.enable = true;                                                                                                                                          
}      
