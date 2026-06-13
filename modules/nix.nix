{...}: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    optimise.automatic = true;

    # GitHub auth for flake input fetches (raises the anonymous 60 req/hr API
    # limit to 5000). The token is kept OUT of the Nix store / git: only this
    # !include directive is rendered into /etc/nix/nix.conf; the secret lives in
    # a root-owned 0600 file you create by hand:
    #   sudo install -m 0600 /dev/null /etc/nix/access-tokens.conf
    #   echo 'access-tokens = github.com=ghp_xxx' | sudo tee /etc/nix/access-tokens.conf
    extraOptions = ''
      !include /etc/nix/access-tokens.conf
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      download-buffer-size = 524288000;
      sandbox = true;

      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes" "read-only-local-store"];

      trusted-users = ["@wheel"];

      warn-dirty = false;

      substituters = [
        # "http://192.168.1.33:5000"
        "https://hyprland.cachix.org"
        "https://devenv.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-substituters = ["https://hyprland.cachix.org" "https://devenv.cachix.org"];
      trusted-public-keys = [
        # "my-nix-cache-1:qi3NxfRFMznSZEGhHa3fihaD3szdPbIprXpFylvNFw4=%"
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
