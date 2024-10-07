{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    flocken = {
      url = "github:mirkolenz/flocken/v2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      flake-parts,
      systems,
      flocken,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;
      imports = [
        inputs.treefmt-nix.flakeModule
      ];
      perSystem =
        {
          pkgs,
          system,
          config,
          ...
        }:
        {
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              gofmt.enable = true;
              nixfmt.enable = true;
            };
          };
          checks = {
            inherit (config.packages) default;
          };
          packages = {
            default = pkgs.callPackage ./. { };
            docker = pkgs.callPackage ./docker.nix {
              caddy = config.packages.default;
            };
          };
          apps.docker-manifest = flocken.legacyPackages.${system}.mkDockerManifest {
            github = {
              enable = true;
              token = "$GH_TOKEN";
            };
            # version = config.packages.default.version;
            images = with self.packages; [
              x86_64-linux.docker
              aarch64-linux.docker
            ];
          };
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              go
              config.treefmt.build.wrapper
            ];
          };
        };
    };
}
