{ pkgs, catppuccin-helix ,...}: {
  xdg.configFile."helix/themes".source = "${catppuccin-helix}/themes/default";
  programs.helix = {
    enable = true;
    # package = pkgs.helix;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        cursorline = true;
        color-modes = true;
        lsp.display-messages = true;
      };
      keys.insert = {
        j.k = "normal_mode";
      };
    };
  };
}