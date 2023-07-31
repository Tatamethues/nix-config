{ pkgs, catppuccin-helix ,...}: {
  xdg.configFile."helix/themes".source = "${catppuccin-helix}/themes/default";

  home.packages = with pkgs;[
    nil
  ];
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