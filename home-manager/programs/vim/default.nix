{ pkgs, ... }:
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
