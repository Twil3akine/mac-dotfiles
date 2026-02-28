# macOS Dotfiles

このリポジトリは、macOSのターミナルおよび開発環境の設定ファイル（dotfiles）を `GNU Stow` を用いて一元管理するためのものです。

## 🛠 管理しているツール群

- **Terminal:** [Ghostty](https://ghostty.org/) (透過・Catppuccin Mochaテーマ)
- **Shell:** [Fish](https://fishshell.com/) + [Starship](https://starship.rs/)
- **Multiplexer:** [Zellij](https://zellij.dev/) (専用の `dev` レイアウト化)
- **Editor:** [Zed](https://zed.dev/) (メインエディタ)
- **Editor (CLI):** [Neovim](https://neovim.io/) ([LazyVim](https://www.lazyvim.org/) ベース + 透過設定)
- **AI CLI:** [aichat](https://github.com/sigoden/aichat)
- **Toolchain/Env:** [mise](https://mise.jdx.dev/)
- **CLI Utilities:** [GitHub CLI (`gh`)](https://cli.github.com/)
- **Launcher:** [Raycast](https://www.raycast.com/)

---

## 🚀 新しいMacでの復元方法 (Install)

新しい環境にこの設定とツール群を適用する手順です。あらかじめHomebrewがインストールされていることを前提とします。

### 1. リポジトリのクローン

macOS標準のGitを利用して、ホームディレクトリ直下にクローンします。

```fish
git clone https://github.com/twil3akine/mac-dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Brewfileによるパッケージの一括復元

`Brewfile` に記載されているすべてのCLIツール（`stow` や `fish` など）と、GUIアプリケーション（`zed` や `raycast` など）を全自動でインストールします。

```fish
brew bundle
```

### 3. Stowによるシンボリックリンクの展開

`stow` コマンドを使って、各設定ファイルのリンクを所定の場所に自動配置します。

```fish
stow fish ghostty zellij nvim aichat gh mise raycast zed
```

※ 展開時に `File exists` エラーが出た場合は、既存のデフォルト設定ファイルと衝突しています。既存のファイルを削除（またはリネーム退避）してから再度実行してください。

---

## 🔄 設定の更新と追加方法

### 既存の設定を変更した場合

`~/.config/nvim/` などのファイルはすでに `~/dotfiles/` へのシンボリックリンクになっているため、普段通りエディタで設定を変更するだけで、自動的に `dotfiles` 内のファイルも更新されます。

### 新しいアプリを管理下に追加する場合（例：`btm`）

1. `~/dotfiles` 内にアプリ名のフォルダとその階層を作ります。

```fish
mkdir -p ~/dotfiles/bottom/.config/bottom
```

2. 既存の設定ファイルを移動させます。

```fish
mv ~/.config/bottom/bottom.toml ~/dotfiles/bottom/.config/bottom/
```

3. Stowでリンクを張ります。

```fish
cd ~/dotfiles
stow bottom
```

---

## 🤖 バックアップの自動化 (Cron)

このリポジトリは、Macの `cron` を利用して「Homebrewのインストールリストの更新」と「設定ファイルのGitへのプッシュ」を定期的に自動実行して運用しています。

**現在のCron設定の確認:**

```fish
crontab -l
```

**推奨されるCronの設定例 (毎週日曜12時に実行):**
`crontab -e` で以下を追記します。コミット前に `brew bundle dump` が走るため、新しくインストールしたパッケージも自動で記録されます。

```cron
PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
0 12 * * 0 cd ~/dotfiles/ && brew bundle dump --force && git add . && git diff --staged --quiet || (git commit -m "chore: auto update" && git push origin main)
```

**手動で即座にバックアップを行う場合:**

```fish
cd ~/dotfiles
brew bundle dump --force
git add .
git commit -m "chore: update dotfiles and Brewfile"
git push origin main
```
