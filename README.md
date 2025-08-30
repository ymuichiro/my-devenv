# my devenv 

python, nodejs, azure-cli, terraform, postgres の開発環境を提供します。

## Install for Mac 

### nix のインストール

```bash
curl -L https://github.com/NixOS/experimental-nix-installer/releases/download/0.27.0/nix-installer.sh | sh -s -- install
```

bash の更新

```bash
nix-env --install --attr bashInteractive -f https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable
```

devenv のインストール

```bash
nix-env --install --attr devenv -f https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable
```

### direnv のインストール

```bash
brew install direnv
```

zshrc の最後に追加

```.zshrc
eval "$(direnv hook zsh)"
```

## 開発環境に入る

`devenv up` により postgresql を起動し、`devenv shell` で開発用の shell に入ります。

```bash 
devenv up -d
devenv shell
```

環境へアクセスすると次のようにツールがインストールされた状態で shell が起動します。

```bash
git: 2.50.1 | node: v22.17.0 | npm: 10.9.2 | pnpm: 10.12.1 | terraform: 1.6.6 | psql: 17.5 | az: 2.58.0
```

## 開発環境を終了する場合

```bash
devenv processes down
```

## Links

- devenv
  - https://devenv.sh/getting-started/
- nix packages
  - https://search.nixos.org/packages
- old nix packages
  - https://lazamar.co.uk/nix-versions
- for Rosetta
  - https://devenv.sh/common-patterns/#run-x86-binaries-on-apple-silicon-with-rosetta
