{pkgs, ...}: {
  xdg.terminal-exec.enable = true;
  xdg.userDirs = {
  enable = true;
  createDirectories = true;
};

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];

      config = {
        common = {default = ["gtk"];};
        hyprland = {default = ["hyprland" "gtk"];};
      };
    };

    mimeApps.enable = true;

    mimeApps.defaultApplications = let
      gen_default_app = app: list:
        builtins.listToAttrs (map (type: {
            name = type;
            value = app;
          })
          list);
    in
      gen_default_app "com.google.Chrome.desktop" [
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/chrome"
        "text/html"
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/xhtml+xml"
        "application/x-extension-xhtml"
        "application/x-extension-xht"
      ]
      // gen_default_app "org.pwmt.zathura.desktop" [
        "application/pdf"
        "application/oxps"
        "application/epub+zip"
        "application/x-fictionbook"
      ];
  };
}
