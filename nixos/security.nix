{ pkgs, ... }:

{

   # Realtime Policy and Watchdog Daemon
   security.rtkit.enable = true;

   # Polkit enable
   security.polkit.enable = true;

}
