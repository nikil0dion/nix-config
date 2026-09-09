{ pkgs, lib, ... }:

{
  # Linux Kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_18;
  boot.kernelParams = lib.mkAfter [
    "splash"
    "quiet"
    "fbcon=nodefer"
    "vt.global_cursor_default=0"
    "usbcore.autosuspend=-1"
    "acpi_rev_override=5"
  ];

  # kexec_load_disabled is a sysctl, not a cmdline arg
  boot.kernel.sysctl."kernel.kexec_load_disabled" = 1;  # block kexec after boot

  # Default systemd without SELinux
  systemd.package = pkgs.systemd;
}
