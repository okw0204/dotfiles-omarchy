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

既に配布済みの実ファイルはこの移行で削除しない。これら以外の既存設定・スキルはそのまま残す。
