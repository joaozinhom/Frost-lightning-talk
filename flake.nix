{
  description = "Slidev presentation environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs_20
          ];

          shellHook = ''
            # redirect npm global to writable dir inside project
            export NPM_CONFIG_PREFIX="$PWD/.npm-global"
            export PATH="$PWD/.npm-global/bin:$PATH"

            mkdir -p .npm-global

            if ! command -v slidev &> /dev/null; then
              echo "installing slidev locally..."
              npm install -g @slidev/cli
            fi

            echo ""
            echo "Slidev ready. commands:"
            echo "  slidev slides.md        -- start dev server"
            echo "  slidev build slides.md  -- build static"
            echo "  slidev export slides.md -- export to PDF"
            echo ""
          '';
        };
      });
}