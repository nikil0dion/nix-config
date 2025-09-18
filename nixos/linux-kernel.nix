{ pkgs, ... }:

{
  # Linux Kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
  boot.kernelParams = [ 
    "splash"
    "quiet"
    "fbcon=nodefer"
    "vt.global_cursor_default=0"
    "kernel.modules_disabled=1"
    "lsm=landlock,lockdown,yama,integrity,apparmor,bpf,tomoyo"
    "usbcore.autosuspend=-1"
    "video4linux"
    "acpi_rev_override=5"
    "kernel.kexec_load_disabled=1"
  ];

  # Используем стандартный systemd без SELinux
  systemd.package = pkgs.systemd;
}
