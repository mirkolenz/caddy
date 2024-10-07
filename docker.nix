{
  lib,
  dockerTools,
  caddy,
  cacert,
  tzdata,
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
    mkdir -m 1777 tmp
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
