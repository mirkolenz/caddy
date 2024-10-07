# https://github.com/NixOS/nixpkgs/blob/nixpkgs-unstable/pkgs/by-name/ca/caddy/package.nix
{
  lib,
  caddy,
}:
caddy.overrideAttrs (prev: {
  version = "0.1.0";
  src = ./.;
  vendorHash = "sha256-kcO64swHlak3Tarwic/eKdXVDy58NTilTXfBCm0Ru38=";
  subPackages = [ ];
  ldflags = [
    "-s"
    "-w"
  ];
  meta = with lib; {
    description = "Custom Caddy Build";
    homepage = "https://github.com/mirkolenz/caddy";
    license = licenses.mit;
    mainProgram = "caddy";
    maintainers = with maintainers; [ mirkolenz ];
  };
})
