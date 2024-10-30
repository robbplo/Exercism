{
  inputs = {
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
    lexical.url = "github:lexical-lsp/lexical";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      flake-parts,
      ...
    }@inputs:
    let
      erlangVersion = "erlang_26";
      elixirVersion = "elixir_1_17";
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;

      perSystem =
        {
          # self',
          config,
          system,
          pkgs,
          lib,
          ...
        }:
        {
          _module.args.pkgs = import nixpkgs {
            inherit system;
            overlays = [
              (
                final: _:
                let
                  erlang = final.beam.interpreters.${erlangVersion};
                  beamPackages = final.beam.packages.${erlangVersion};
                  elixir = beamPackages.${elixirVersion};
                  lexical = inputs.lexical.packages.${system}.default;
                in
                {
                  inherit erlang elixir lexical;
                }
              )
            ];
          };

          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              exercism

              erlang
              elixir
              lexical

              ghc
              stack
              haskellPackages.cabal-install
              haskellPackages.haskell-language-server
            ];
          };

          formatter = pkgs.nixfmt-rfc-style;
        };
    };
}
