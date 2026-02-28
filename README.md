# macOS Dotfiles

このリポジトリは、macOSのターミナルおよび開発環境の設定ファイル（dotfiles）を `GNU Stow` を用いて一元管理するためのものです。

## 🛠 管理しているツール群

- **Terminal:** [Ghostty](https://ghostty.org/) (透過・Catppuccin Mochaテーマ)
- **Shell:** [Fish](https://fishshell.com/) + [Starship](https://starship.rs/)
- **Multiplexer:** [Zellij](https://zellij.dev/) (専用の `dev` レイアウト化)
- **Editor:** [Neovim](https://neovim.io/) ([LazyVim](https://www.lazyvim.org/) ベース + 透過設定)
- **AI CLI:** [aichat](https://github.com/sigoden/aichat) (ローカルのOllama `qwen2.5-coder:14b` と連携、Role設定済み)

---

## 🚀 新しいMacでの復元方法 (Install)

新しい環境にこの設定を適用する手順です。

### 1. 必須ツールのインストール
Homebrewを使って `stow` と必須ツール群をインストールします。

```fish
brew install stow fish starship neovim zellij bottom aichat glow
```

### 2. リポジトリのクローン

ホームディレクトリ直下にクローンします。

```fish
git clone [https://github.com/あなたのユーザー名/mac-dotfiles.git](https://github.com/あなたのユーザー名/mac-dotfiles.git) ~/dotfiles
cd ~/dotfiles
```

### 3. Stowによるシンボリックリンクの展開

`stow` コマンドを使って、各設定ファイルのリンクを所定の場所（`~/.config` など）に自動配置します。

```fish
stow fish ghostty zellij nvim aichat
```

※ 展開時に `File exists` エラーが出た場合は、既存のデフォルト設定ファイルと衝突しています。既存のファイルを削除（またはリネーム退避）してから再度実行してください。

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

## 🤖 バックアップの自動化 (Cron)

このリポジトリは、Macの `cron` を利用して定期的に自動コミット＆プッシュされるように運用しています。

**現在のCron設定の確認:**

```fish
crontab -l
```

**手動でバックアップ（Gitへの反映）を行う場合:**

```fish
cd ~/dotfiles
git add .
git commit -m "chore: update dotfiles"
git push origin main
```

**Next Step:**
コピペして保存できたら、せっかくなので手動で一度コミットしてGitHubにプッシュしておきましょう。ターミナルで以下を実行します。

```fish
cd ~/dotfiles
git add README.md
git commit -m "docs: add README.md"
git push origin main
```