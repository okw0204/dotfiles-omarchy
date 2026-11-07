# Arch Linux / Omarchy 固有の追加設定。
# 共有設定（okw0204/dotfiles の ~/.config/fish/config.fish）の末尾で読み込まれる。

if status is-interactive
    # Obsidian Vault パスの正本。Hermes 側でも ~/.hermes/.env に同じ値をミラーしている。
    set -gx OBSIDIAN_VAULT_PATH "$HOME/ghq/github.com/okw0204/Obsidian"

    # 試行用ディレクトリの補完（try が fish 出力に対応している前提）
    if type -q try
        try init ~/Work/tries | source
    end

    # Arch の fzf パッケージが配置する補完とキーバインド
    if type -q fzf
        if test -f /usr/share/fzf/completion.fish
            source /usr/share/fzf/completion.fish
        end
        if test -f /usr/share/fzf/key-bindings.fish
            source /usr/share/fzf/key-bindings.fish
        end
    end

    if type -q hermes
        abbr -a h hermes
    end
    # 共有設定の c（omp --allow-home）を Arch では opencode に置き換える
    abbr -a c opencode
end

# opencode 本体（インストーラーの既定パス）
fish_add_path $HOME/.opencode/bin

# Linux のブロックデバイス操作ヘルパー（存在する場合のみ）
if test -f $__fish_config_dir/linux-disk.fish
    source $__fish_config_dir/linux-disk.fish
end
