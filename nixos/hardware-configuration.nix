{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ "msr" "i915" "coretemp" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.blacklistedKernelModules = [ "kvm_intel" ];
  boot.tmp.cleanOnBoot = true;
  # hibernation luks
  boot.resumeDevice = "/dev/disk/by-uuid/c390e2e3-8687-428f-8443-18c43218273f";
  boot.kernelParams = [ "resume_offset=1320192" ]; 
  boot.initrd.systemd.enable = true;
  boot.initrd.supportedFilesystems = [ "btrfs" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d803212c-104c-4157-bf10-6dbe315115b5";
      fsType = "btrfs";
      options = [ 
        "noatime"           # safer than noatime: update atime only when needed
        "space_cache=v2"     # safe: improved space cache performance
      ];
    };

  # Your LUKS name
  boot.initrd.luks.devices."space".device = "/dev/disk/by-uuid/c390e2e3-8687-428f-8443-18c43218273f";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8000-4FS2";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ 
    { device = "/swap/swapfile";
    }];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
