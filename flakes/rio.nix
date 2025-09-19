{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    inputs.rio.packages.${pkgs.system}.rio
  ];
}
