# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
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
    tmp.cleanOnBoot = true;
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

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
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

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
      shawn = {
        isNormalUser = true;
        description = "Shawn Parker";
        extraGroups = [ "docker" "rootless" "networkmanager" "wheel" ];
        packages = with pkgs; [];
      };
      rootless = {
        isNormalUser = false;
        isSystemUser = true;
        description = "Docker rootless user";
        group = "rootless";
        extraGroups = [];
        packages = with pkgs; [];
      };
    };
    
    groups = {
      rootless = {};
    };
    
    defaultUserShell = pkgs.zsh;
  };

  nix = {
    daemonCPUSchedPolicy = "batch";
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment = {
    sessionVariables = rec {
      VISUAL = "vim";
    };

    systemPackages = with pkgs; [
      bat
      curl
      exa
      gnumake
      hdparm
      htop
      lm_sensors
      rsync
      screen
      wget
      ((vim.override { }).customize {
        vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
          start = [ "vim-nix" ];
          opt = [];
        };
        vimrcConfig.customRC = ''
          source $VIMRUNTIME/defaults.vim
          
          set tabstop=4
          set autoindent
          set colorcolumn=80
          
          au BufRead,BufNewFile *.nix set filetype=nix
          autocmd FileType nix setlocal shiftwidth=2 softtabstop=2 expandtab
        '';
      })
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

  programs.vim = {
    defaultEditor = true;
  };

  programs.git = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    
    shellAliases = {
      bat = "bat --theme=Coldark-Cold --italic-text=always";
      ls = "exa -gF --git --long --header --time-style=long-iso";
      mv = "mv --verbose";
      rm = "rm --verbose";
    };

    ohMyZsh = {
      enable = true;
      plugins = [ 
        "git" 
      ];
      theme = "eastwood";
    };
  };

  # Stupid n00b hack to list all installed packages in /etc/current-system-packages
  environment.etc."current-system-packages".text = let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in formatted;

  fileSystems."/".options = [ "noatime" "discard" ];
  fileSystems."/mnt/data".options = [ "noatime" "discard" ];
  fileSystems."/mnt/diskface".options = [ "noatime" "discard" "nodev" ];

  console = {
    earlySetup = true;
    font = "${pkgs.kbd}/share/consolefonts/Lat2-Terminus16.psfu.gz";
  };
}
