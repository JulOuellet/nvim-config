{
  description = "Neovim config dependencies";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};

        nvimDeps = with pkgs; [
          # neovim plugins dependencies
          ripgrep
          gcc
          nodejs
          go
          fd
          tree-sitter

          # lsp packages
          lua-language-server
          nixd
          vscode-langservers-extracted # json, css, html
          bash-language-server
          gopls
          sqls
          templ
          pyright
          jdt-language-server
          nodePackages.typescript-language-server

          # formatter packages
          gofumpt
          gotools
          alejandra
          stylua
          nodePackages.prettier
          pgformatter
          jq
          shfmt
          ruff
        ];
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = nvimDeps;
        };

        packages.deps = nvimDeps;
      }
    );
}
