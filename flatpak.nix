{ inputs, ... }:
{
  services.flatpak = {
    update.onActivation = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly"; # Default value
    };
    packages = [
      "org.telegram.desktop"
      "com.obsproject.Studio"
      "com.brave.Browser"
      "com.spotify.Client"
      "com.google.Chrome"
      "dev.vencord.Vesktop"
      "org.mozilla.firefox"
      "com.getpostman.Postman"
      "com.gopeed.Gopeed"
      "org.jdownloader.JDownloader"
      "com.rustdesk.RustDesk"
      # "com.heroicgameslauncher.hgl"
    ];
    uninstallUnmanaged = true;

    restartOnFailure = {
      enable = true;
      restartDelay = "60s";
      exponentialBackoff = {
        enable = false;
        steps = 10;
        maxDelay = "1h";
      };
    };

    overrides = {
      "com.getpostman.Postman".Context.sockets = [
        "wayland"
        "!x11"
        "!fallback-x11"
      ];

      "dev.vencord.Vesktop".Context.sockets = [
        "wayland"
        "!x11"
        "!fallback-x11"
      ];
    };
  };
}
