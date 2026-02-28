if status is-interactive
    # 既存のエイリアス
    alias c="clear"
    alias e="exit"

    # Modern Unix エイリアス
    alias ls="eza --icons --git --no-user"
    alias ll="eza -l --icons --git --no-user"
    alias la="eza -la --icons --git --no-user"
    alias tree="eza --tree --icons"
    alias cat="bat"
    alias grep="rg"

    # Yazi 起動用関数 (終了時にそのディレクトリに残る)
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    # ツールの初期化 (これがないと動きません)
    starship init fish | source
    zoxide init fish | source
    mise activate fish | source
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

if set -q ZELLIJ
    clear
end
