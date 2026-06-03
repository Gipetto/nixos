{ pkgs }:
let
  version = "1.0.2";
  withAlpha = color: alpha: "${color}${alpha}";

  palette = rec {
    transparent = "#00000000";
    industrialCharcoal = "#2a2a28";
    charcoalLight = "#3a3a38";
    dadoGreen = "#5a8a73";
    infoBlue = "#5b7a8e";
    machineryGray = "#6b6b68";
    seafoam = "#7fb5a0";
    agedRust = "#8b5a3c";
    concreteBase = "#a69f95";
    safetyRed = "#c83e3a";
    dustySand = "#c9b89a";
    hazardOrange = "#d67d3e";
    creamDark = "#d8d0c5";
    instrumentCream = "#e8e0d5";
    cautionYellow = "#f2b632";
    creamLight = "#f2ece3";
    white = "#ffffff";

    dadoGreen20 = withAlpha dadoGreen "20";
    dadoGreen30 = withAlpha dadoGreen "30";
    dadoGreen40 = withAlpha dadoGreen "40";
    dadoGreen50 = withAlpha dadoGreen "50";
    dadoGreen60 = withAlpha dadoGreen "60";
    dadoGreen80 = withAlpha dadoGreen "80";
    infoBlue20 = withAlpha infoBlue "20";
    infoBlue40 = withAlpha infoBlue "40";
    machineryGray40 = withAlpha machineryGray "40";
    machineryGray80 = withAlpha machineryGray "80";
    machineryGrayCC = withAlpha machineryGray "cc";
    seafoam20 = withAlpha seafoam "20";
    seafoam30 = withAlpha seafoam "30";
    seafoam40 = withAlpha seafoam "40";
    seafoam50 = withAlpha seafoam "50";
    seafoam80 = withAlpha seafoam "80";
    concreteBase40 = withAlpha concreteBase "40";
    concreteBase80 = withAlpha concreteBase "80";
    concreteBaseCC = withAlpha concreteBase "cc";
    safetyRed20 = withAlpha safetyRed "20";
    safetyRed40 = withAlpha safetyRed "40";
    hazardOrange30 = withAlpha hazardOrange "30";
    hazardOrange40 = withAlpha hazardOrange "40";
    cautionYellow40 = withAlpha cautionYellow "40";
    cautionYellow60 = withAlpha cautionYellow "60";
  };

  render = name: src: replacements: pkgs.replaceVarsWith {
    inherit name src replacements;
  };

  ghosttyLight = render "birren-industrial-light-${version}" ./ghostty/birren-industrial-light.in {
    inherit version;
    inherit (palette)
      agedRust
      cautionYellow
      concreteBase
      dadoGreen
      hazardOrange
      industrialCharcoal
      infoBlue
      instrumentCream
      machineryGray
      safetyRed
      seafoam
      ;
  };

  vscodeLight = render "birren-industrial-light-${version}.json" ./vscode/themes/birren-industrial-light.json.in {
    inherit (palette)
      agedRust
      cautionYellow
      cautionYellow40
      cautionYellow60
      concreteBase
      concreteBase40
      concreteBase80
      concreteBaseCC
      creamDark
      creamLight
      dadoGreen
      dadoGreen20
      dadoGreen30
      dadoGreen40
      dadoGreen50
      dadoGreen60
      dadoGreen80
      hazardOrange
      hazardOrange40
      industrialCharcoal
      infoBlue
      infoBlue40
      instrumentCream
      machineryGray
      safetyRed
      safetyRed20
      safetyRed40
      seafoam
      transparent
      white
      ;
  };

  vscodeDark = render "birren-industrial-dark-${version}.json" ./vscode/themes/birren-industrial-dark.json.in {
    inherit (palette)
      agedRust
      cautionYellow
      cautionYellow40
      cautionYellow60
      charcoalLight
      concreteBase
      dadoGreen
      dadoGreen20
      dadoGreen40
      dadoGreen60
      dustySand
      hazardOrange
      hazardOrange40
      industrialCharcoal
      infoBlue
      infoBlue40
      instrumentCream
      machineryGray
      machineryGray40
      machineryGray80
      machineryGrayCC
      safetyRed
      safetyRed20
      safetyRed40
      seafoam
      seafoam20
      seafoam30
      seafoam40
      seafoam50
      seafoam80
      transparent
      ;
  };

  vscodeManifest = render "package.json" ./vscode/package.json.in {
    inherit version;
  };

  vimColors = render "birren-industrial-${version}.vim" ./vim/colors/birren-industrial.vim.in {
    inherit version;
    inherit (palette)
      agedRust
      cautionYellow
      charcoalLight
      concreteBase
      creamDark
      dadoGreen
      dadoGreen20
      dadoGreen40
      dadoGreen50
      dustySand
      hazardOrange
      hazardOrange30
      industrialCharcoal
      infoBlue
      infoBlue20
      instrumentCream
      machineryGray
      safetyRed
      safetyRed20
      seafoam
      seafoam20
      seafoam40
      ;
  };

  palettePreview = render "birren-industrial-palette-${version}.svg" ./palette.svg.in {
    inherit version;
    inherit (palette)
      agedRust
      cautionYellow
      charcoalLight
      concreteBase
      creamLight
      dadoGreen
      dustySand
      hazardOrange
      industrialCharcoal
      infoBlue
      instrumentCream
      machineryGray
      safetyRed
      seafoam
      ;
  };
in
{
  inherit palette version;
  ghostty.light = ghosttyLight;
  preview.svg = palettePreview;

  vscode = pkgs.runCommand "birren-industrial-vscode-source-${version}" { } ''
    mkdir -p "$out/themes"
    cp ${vscodeManifest} "$out/package.json"
    cp ${./vscode/README.md} "$out/README.md"
    cp ${vscodeDark} "$out/themes/birren-industrial-dark.json"
    cp ${vscodeLight} "$out/themes/birren-industrial-light.json"
  '';

  vim = pkgs.runCommand "birren-industrial-vim-source-${version}" { } ''
    mkdir -p "$out/colors"
    cp ${vimColors} "$out/colors/birren-industrial.vim"
  '';
}
