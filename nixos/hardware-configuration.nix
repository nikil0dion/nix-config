{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.blacklistedKernelModules = [ "kvm_intel" ];
  boot.tmp.cleanOnBoot = true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d803212c-104c-4157-bf10-6dbe315115b5";
      fsType = "btrfs";
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
