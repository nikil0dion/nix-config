{ pkgs, ... }:

{

   # Enable X11 windowing system
   services.xserver.enable = true;

   # Enable GDM 
   services.xserver.displayManager.gnome.enable = true;

   # Enable GNOME
   services.xserver.desktopManager.gnome.enable = true;

    # Audio service 
   services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
   };

   # Enable Bluethooth
   hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
    services.blueman.enable = true; 

}
    
