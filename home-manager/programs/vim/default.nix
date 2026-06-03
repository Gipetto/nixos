{ pkgs, ... }:
let
  birrenIndustrial = import ../../themes/birren-industrial { inherit pkgs; };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = true;
    withRuby = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      plenary-nvim
      telescope-nvim
      vim-better-whitespace
      (pkgs.vimUtils.buildVimPlugin {
        pname = "birren-industrial";
        version = "1.0.0";
        src = birrenIndustrial.vim;
      })
      (nvim-treesitter.withPlugins (p: [
        p.css
        p.javascript
        p.scss
        p.svelte
        p.typescript
      ]))
    ];
    extraConfig = builtins.readFile ./vimrc;
  };
}
