{
  inputs =
    {
      flake-utils = { url = "github:numtide/flake-utils"; };
      nix-npm-buildpackage = { url = "github:serokell/nix-npm-buildpackage"; };
    };

  outputs =
    { self, flake-utils, nix-npm-buildpackage, nixpkgs }:
    flake-utils.lib.eachDefaultSystem
      (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          buildPackage = pkgs.callPackage nix-npm-buildpackage { };
          bundle = buildPackage.buildNpmPackage {
            src = ./.;
            npmBuild = "npm run build";
            extraEnvVars = { NODE_ENV = "production"; };
          };
          node-modules = buildPackage.mkNodeModules { src = ./.; pname = "npm"; version = "8"; };
        in
        {
          defaultPackage = pkgs.stdenv.mkDerivation
            (
              {
                name = "nodeserver-pkg";
                buildInputs = [ pkgs.nodejs ];
                src = ./.;
                installPhase = '' 
                      export NODE_ENV=production
                      export NODE_PATH=${node-modules}/node_modules
                      export npm_config_cache=${node-modules}/config-cache
                      mkdir -p $out
                      npm run build
                      cp -r ./dist/. $out
                    '';
              }
            );
          # defaultPackage = bundle;
          devShell = pkgs.mkShell
            (
              {
                name = "nodeserver-ahell";
                buildPhase = "";
                buildInputs = [ pkgs.esbuild pkgs.nodejs ];
                src = ./.;
                shellHook = '' 
                      export NODE_ENV=development
                      export NODE_PATH=${node-modules}/node_modules
                      export npm_config_cache=~/npm-cache
                      mkdir -p $out/bin
                      echo "Welcome to your nix development shell"
                      echo "Run 'npm run watch' to run dev server"
                    '';
                # npm config set package-lock-only=true
              }
            );
        }
      );
}


