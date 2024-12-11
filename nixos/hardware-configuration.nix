{ config, lib, pkgs, modulesPath, ... }: 

{ 
  import = [ ];
 
  #boot.tmp.cleanOnBoot = true;
  #boot.tmp.tmpfsSize = "5GB";
  boot.initrd.availableKernelModules = [
    "ahci"      # SATA controller
    "nvme"      # NVMe SSD support
    "xhci_pci"  # USB 3.0/3.1
    "amdgpu"    # AMD GPU driver (for Ryzen APUs) 
    ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  # Bootloader 
  boot.initrd.enable = true;
  boot.initrd.systemd.enable = true;
  boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  
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
