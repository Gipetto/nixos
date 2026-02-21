{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  # Tower-specific filesystem (separate /home partition)
  fileSystems."/home" = {
    fsType = "ext4";
    device = "/dev/disk/by-uuid/34f36b8f-3c7d-4b7e-b430-2fd4c75205ce";
  };

  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub.enable = false;

  # Networking
  networking.hostName = "tower";
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Hyprland (tower-specific)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  
  # System packages (tower-specific, minimal)
  environment.systemPackages = with pkgs; [
    vim      # For root user
    waybar   # Desktop
    kitty    # Terminal
  ];

  # SSH
  services.openssh.enable = true;

  system.stateVersion = "25.11";
}