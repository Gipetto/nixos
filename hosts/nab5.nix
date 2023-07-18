# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ 
    # Include the results of the hardware scan.
    ./nab5-hardware-configuration.nix
  ];

  # Bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernel.sysctl = {
      "vm.swappiness" = 10;
    };
    kernelParams = [ "i915.fastboot=1" ];
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "i915" ];
    blacklistedKernelModules = [
      "mt7921e" # lazier than uninstalling the wifi/bluethooth card
    ];
  };

  hardware = {
    bluetooth.enable = false;
  };

  powerManagement.cpuFreqGovernor = lib.mkForce "powersave";
  powerManagement.powerUpCommands = ''
${pkgs.hdparm}/sbin/hdparm -B 254 /dev/sdb
  '';

  networking = {
    networkmanager.enable = true;
    hostName = "nab5";
    wireless.enable = false;
    enableIPv6 = false;
  };

  users = {
    users = {
      rootless = {
        isNormalUser = false;
        isSystemUser = true;
        description = "Docker rootless user";
        group = "rootless";
      };
    };
    
    groups = {
      rootless = {};
    };
  };

  nix.daemonCPUSchedPolicy = "batch";

  # Packages
  environment = {
    systemPackages = with pkgs; [
      hdparm
      lm_sensors
    ];

    shells = with pkgs; [ zsh ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.openssh.enable = true;
  services.avahi.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false; # enable firewall once docker is settled in

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    autoPrune.enable = true;
    autoPrune.dates = "weekly";
    #rootless = {
    #  enable = true;
    #  setSocketVariable = true;
    #};
  };

  fileSystems."/".options = [ "noatime" "discard" ];
  fileSystems."/mnt/data".options = [ "noatime" "discard" ];
  fileSystems."/mnt/diskface".options = [ "noatime" "discard" "nodev" ];
}
