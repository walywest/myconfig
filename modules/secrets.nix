# Secret-management agents.
#
# A bare Hyprland session has no desktop environment to provide these daemons,
# so we wire them explicitly here.
#
# gnome-keyring is the Secret Service (org.freedesktop.secrets) provider. It:
#   * stores application secrets (browsers, chat clients, etc.), and
#   * acts as NetworkManager's *secret agent*, so Wi-Fi / VPN passwords are kept
#     in the encrypted per-user keyring instead of sitting in plaintext under
#     /etc/NetworkManager/system-connections.
#
# PAM unlocks the "login" keyring with your login password at TTY1 login (you
# boot to a getty and `exec Hyprland` from the shell profile), so there is no
# extra unlock prompt once you've logged in.
{pkgs, ...}: {
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # GPG agent for GnuPG keys. SSH support is intentionally left OFF so it does
  # not fight gnome-keyring over $SSH_AUTH_SOCK — pick one SSH agent, not two.
  programs.gnupg.agent.enable = true;

  # Optional GUI to inspect / manage keyrings and stored secrets.
  environment.systemPackages = [pkgs.seahorse];
}
