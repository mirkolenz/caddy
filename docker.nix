{
  lib,
  dockerTools,
  caddy,
  cacert,
  tzdata,
  coreutils,
}:
dockerTools.buildLayeredImage {
  name = "caddy";
  tag = "latest";
  created = "now";
  contents = [
    cacert
    tzdata
  ];
  extraCommands = ''
    ${coreutils}/bin/mkdir -m 1777 tmp
  '';
  config = {
    entrypoint = [ (lib.getExe caddy) ];
    cmd = [
      "--config"
      "/etc/caddy/Caddyfile"
      "--adapter"
      "caddyfile"
    ];
  };
}
