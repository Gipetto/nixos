{ config, system, ... }:
{
  system.autoUpgrade = {
    enable = true;
    #flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs-unstable"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "15min";
  };
}
