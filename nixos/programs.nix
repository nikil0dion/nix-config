{ pkgs, ... }:

{

  # Enable dconf
  programs.dconf.enable = true;
   
  # Hyperland enable
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.waybar.enable = true;
  
  # Shell Bash
  programs.defaultUserShell = pkgs.bash;
  programs.bash.enable = true;

  # Firefox browser
  programs.firefox.enable = true;

}
