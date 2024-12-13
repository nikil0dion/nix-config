{ config, lib, pkgs, modulesPath, ... }: 

{ 
  import = [ ];
 
  #boot.tmp.cleanOnBoot = true;
  #boot.tmp.tmpfsSize = "5GB";
 
  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Luks 
  boot.initrd.luks.device."device".device = "/dev/disk/by-uuid/2dfssdew-dsfds-fdfd-fdsd-ddsfdsfdsfP";
   
  fileSystems."/" = 
    { device = "dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
    };

  fileSystems."/boot" = 
    { device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat"; 
    };

   swapDevices = [
    {
      device = "/swap/swapfile";
      size = 8196;
    }
  ];
}
