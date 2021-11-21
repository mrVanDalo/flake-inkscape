{
  description = "inkscape extensions";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.stroke-font = (pkgs.callPackage ./stroke-font.nix { });
        defaultPackage = self.packages.${system}.stroke-font;
        devShell = pkgs.mkShell {
          buildInputs = [
            (pkgs.inkscape-with-extensions.override {
              inkscapeExtensions = [ self.packages.${system}.stroke-font ];
            })
          ];
        };
      }
    );
}
