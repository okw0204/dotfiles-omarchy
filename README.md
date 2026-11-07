# dotfiles-omarchy

Arch Linux／Omarchy 専用の chezmoi source。既存の `okw0204/dotfiles` を改名し、履歴と Arch 用設定を維持している。作業時は [AGENTS.md](AGENTS.md) を読む。

OS に依存しない設定を新しく育てる場所は [dotfiles](https://github.com/okw0204/dotfiles)。そちらは Git と必要なファイルだけのコピーで管理し、chezmoi の管理対象を広げない。

## 改名後の既存クローン

元の `dotfiles` という名前は別のリポジトリで再利用するため、旧 URL の転送には依存しない。Arch 側など既存のクローンでは、旧リポジトリの履歴であることを確認してから次を実行する。

```sh
git remote set-url origin https://github.com/okw0204/dotfiles-omarchy.git
git remote get-url origin
```

ローカルディレクトリの改名は必須ではない。改名する場合は chezmoi の sourceDir と、関連する絶対パスの参照も合わせて更新する。旧クローンに新しい共通設定用 `dotfiles` の履歴を取り込まない。

## Arch での運用

既存の chezmoi 運用を継続する。作業前に `/etc/os-release` と `chezmoi source-path` を確認し、実環境側の未保存の変更を保全する。`chezmoi diff` で差分を確認してから、依頼された対象だけを取り込み・適用する。

WSL2 ではこの source をホームに適用しない。リポジトリの保守はできるが、Arch 実機での動作確認とは区別する。

## 今回の分離範囲

2026-11-07 に追加した次の 3 ファイルは、新しい `dotfiles` へ管理先を移した。

- `dot_omp/agent/AGENTS.md`
- `dot_omp/agent/PERSONALITY.md`
- `dot_agents/skills/herdr/SKILL.md`

既に配布済みの実ファイルは、source からの移行だけでは削除しない。

## 共通設定の移行後

共通の mise・lazygit・スキルと、fish・Git・Neovim の共通部分は `dotfiles` に移した。同じ配置先を両リポジトリから配布しない。こちらは Arch のローカル設定と Omarchy 連携だけを保持する。

新しい環境では、次の順で復元する。

1. `dotfiles` の `README.md` を読み、必要な共通設定を明示的にコピーする。スキルは本体・ライセンス・相対リンクをセットで復元する。
2. Arch のこの source と destination を確認し、ローカル設定と Omarchy 連携を chezmoi で重ねる。既存ファイルは先にバックアップする。
3. 必要なツールを導入し、fish・Git・Neovim で共通設定とローカル設定が読み込まれることを確認する。`mise install` は明示的に行い、このリポジトリから自動起動しない。

共通ファイルの復元をせずに、この source だけで初期環境を構築しない。逆に、移行済みの環境で共通設定を更新するときは `dotfiles` 側だけを更新する。既存環境の `chezmoi re-add` で共通設定を再登録しない。

Node の既存バージョン `25.2.1` は `~/.config/mise/mise.local.toml` と `mise.local.lock` に残している。共通側の Node `24.14.1` より優先される。これは OS 制約ではなく、移行時に Arch の選択を変えないためのローカル設定。

残している環境側の設定は次のとおり。

- fish：`local.fish`（Vault・略語・Arch パッケージ連携）と `linux-disk.fish`（ディスク操作関数）。
- Git：`config.local`（既存の個人識別情報）。共通の `config` から相対 include で読む。
- Neovim：`options.local.lua` と `remote_clipboard.lua`（OSC 52）、`theme.local.lua` のリンクとテーマ再読み込み処理。
- スキル：Omarchy 専用スキルと、それへの Claude／Codex のリンク。

Neovim の初回移行では、旧 `~/.config/nvim/lua/plugins/theme.lua` のリンク自体をバックアップへ移してから共通ファイルをコピーする。リンク先の Omarchy テーマを上書きしないこと。新しいリンクは `theme.local.lua` に配置する。
