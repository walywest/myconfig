{
  pkgs,
  inputs,
  ...
}: {
  programs.direnv.enable = true;
  # environment.systemPackages = [
  #   inputs.devenv.packages.${pkgs.system}.default
  # ];
}
# hash = "1jmiplyf9mfjh2absdwi1zdqiybi3y9l4dcysclpp7x52v2mci88"

