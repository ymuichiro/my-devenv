{ pkgs, lib, config, inputs, ... }:

let
  # Azure CLI v2.58.0 が含まれている特定のnixpkgsコミットを使用
  nixpkgs-azure = import (builtins.fetchGit {
      name = "azure-cli-258-revision";
      url = "https://github.com/NixOS/nixpkgs/";
      ref = "refs/heads/nixos-25.05";
      rev = "cd5f33f23db0a57624a891ca74ea02e87ada2564";
  }) {
    # 現在の devenv 環境の system を継承
    inherit (pkgs) system;
  };
in
{
  # 環境変数の指定
  # https://devenv.sh/basics/
  # env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [ 
    pkgs.git
    pkgs.jq
    pkgs.nodejs_22
    pkgs.terraform

    # Azure CLI v2.58.0
    nixpkgs-azure.azure-cli
  ];

  # https://devenv.sh/languages/
  languages.python.enable = true;
  languages.python.version = "3.11.3";
  languages.javascript.enable = true;
  languages.terraform.enable = true;
  languages.terraform.version = "1.6.6";
  
  # https://devenv.sh/services/
  services.postgres = {
    enable = true;
    createDatabase = true;
    package = pkgs.postgresql;
    initialDatabases = [{ name = "mydb"; user = "postgres"; }];
  };  
  
  enterShell = ''
    # Compact one-line summary with separators
    git_ver=$(command -v git >/dev/null 2>&1 && git --version | sed 's/^git version //' || echo "not found")
    node_ver=$(command -v node >/dev/null 2>&1 && node --version || echo "not found")
    npm_ver=$(command -v npm >/dev/null 2>&1 && npm --version || echo "not found")
    pnpm_ver=$(command -v pnpm >/dev/null 2>&1 && pnpm --version || echo "not found")
    terraform_ver=$(command -v terraform >/dev/null 2>&1 && terraform --version | head -n 1 | sed 's/^Terraform v//' || echo "not found")
    psql_ver=$(command -v psql >/dev/null 2>&1 && psql --version | sed 's/^psql (PostgreSQL) //' || echo "not found")
    az_ver=$(command -v az >/dev/null 2>&1 && az --version | head -n 1 | sed 's/^azure-cli[[:space:]]*//' || echo "not found")

    echo "git: $git_ver | node: $node_ver | npm: $npm_ver | pnpm: $pnpm_ver | terraform: $terraform_ver | psql: $psql_ver | az: $az_ver"
  '';

  # See full reference at https://devenv.sh/reference/options/
}
