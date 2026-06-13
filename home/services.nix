{
  config,
  pkgs,
  ...
}: {
  # Notification daemon
  services.dunst.enable = true;
  programs.btop.enable = true;
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
  };

  # Polkit authentication agent for GUI apps requiring root.
  # hyprpolkitagent is the maintained Hyprland-native agent (replaces the older
  # polkit_gnome one); it draws the auth dialog as a proper Wayland surface.
  systemd.user.services.hyprpolkitagent = {
    Unit = {
      Description = "Hyprland Polkit authentication agent";
      Wants = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  # Tell networkmanager_dmenu (SUPER+N Wi-Fi picker) to render with rofi
  # instead of plain dmenu.
  xdg.configFile."networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = rofi
    rofi_highlight = True
    compact = True
  '';
}
