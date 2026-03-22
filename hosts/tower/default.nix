{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/locale.nix
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      max-jobs = "auto";
      cores = 16;
      extra-sandbox-paths = [
        config.programs.ccache.cacheDir
      ];
    };
  };

  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
      timeout = 2;
      grub.enable = false;
    };
    tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
      tmpfsSize = "50%"; # use up to 32gb of ram for tmpfs
    };
    initrd = {
      systemd.enable = true;
      kernelModules = [
        "dm-mod"
      ];
    };
    kernel = {
      sysctl = {
        "vm.swappiness" = 10; # prefer ram over swap
        "vm.vfs_cache_pressure" = 50; # prefer to keep more in cache
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "splash"
      "nvidia_drm.modeset=1"
      "nvme_core.default_ps_max_latency_us=0"
    ];
    kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];
    consoleLogLevel = 3;
  };

  networking = {
    hostName = "tower";
    networkmanager.enable = true;
  };

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

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v24n.psf.gz";
  };

  systemd = {
    services = {
      nix-daemon.serviceConfig.LimitNOFILE = 1048576;
      NetworkManager-wait-online.enable = false;
    };
    settings = {
      Manager = {
        DefaultTimeoutStartSec = "10s";
        DefaultTimeoutStopSec = "10s";
      };
    };
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    cpu = {
      amd.updateMicrocode = true;
    };
  };

  powerManagement.cpuFreqGovernor = "schedutil";

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    ccache = {
      enable = true;
    };
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "shawn" ];
    };
  };

  services = {
    lvm = {
      enable = true;
    };
    openssh = {
      enable = true;
    };
    xserver = {
      videoDrivers = [
        "nvidia"
      ];
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    greetd = {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd ${pkgs.writeShellScript "start-hyprland" ''
            export LIBVA_DRIVER_NAME=nvidia
            export GBM_BACKEND=nvidia-drm
            export __GLX_VENDOR_LIBRARY_NAME=nvidia
            export WLR_NO_HARDWARE_CURSORS=1
            exec ${config.programs.hyprland.package}/bin/start-hyprland
          ''}";
          user = "greeter";
        };
      };
    };
    fstrim = {
      enable = true;
    };
    avahi = {
      enable = true;
    };
    gnome = {
      gnome-keyring = {
        enable = true;
      };
    };
  };

  security = {
    pam.services.login.enableGnomeKeyring = true;
  };

  environment.systemPackages = with pkgs; [
    libsecret
    pigz # parallel gzip
    pbzip2 # parallel bzip2
    pixz # parallel xz
    ghostty
    kitty
    waybar
  ];

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    autoPrune.enable = true;
    autoPrune.dates = "weekly";
    daemon.settings = {
      experimental = false;
      userland-proxy = false;
      dns = [
        "192.168.1.1"
      ];
    };
    #rootless = {
    #  enable = true;
    #  setSocketVariable = true;
    #};
  };

  fileSystems."/".options = [
    "noatime"
    "nodiratime"
  ];

  fileSystems."/mnt/datum" = {
    device = "/dev/disk/by-uuid/591b46f6-a26d-45e4-8ffd-6c7a7855500b";
    fsType = "ext4";
    options = [
      "noatime"
      "nodiratime"
    ];
  };

  fileSystems."/mnt/containers" = {
    device = "/dev/disk/by-uuid/875a371f-9b1d-4ccd-baac-aa2f4e7c11ad";
    fsType = "ext4";
    options = [
      "noatime"
      "nodiratime"
    ];
  };

  fileSystems."/mnt/scratch" = {
    device = "/dev/disk/by-uuid/5b91b2c5-5eff-4780-b42a-80e9359b7bfc";
    fsType = "ext4";
    options = [
      "noatime"
      "nodiratime"
      "nofail"
    ];
  };

  system.stateVersion = "25.11";
}
