{
  buildGoApplication,
  lib,
  go,
}:
let
  inherit (lib.importTOML ./gomod2nix.toml) mod;
  getVersion = v: lib.removePrefix "v" mod.${v}.version;
in
buildGoApplication {
  pname = "caddy";
  version = getVersion "github.com/caddyserver/caddy/v2";
  inherit go;
  pwd = ./.;
  src = ./.;
}
