# 管理方針

このリポジトリは Arch Linux／Omarchy 専用の chezmoi source。OS 共通設定の新しい保存先は `okw0204/dotfiles`。

- 作業前に `README.md` を読み、`origin` が `okw0204/dotfiles-omarchy` であることを確認する。
- 既存の Arch 設定と chezmoi の管理方式を維持する。WSL2 を基準に書き換えたり、WSL2 の実ファイルを取り込んだりしない。
- WSL2 上でも、依頼されたリポジトリの編集・読み取り検証は行える。実環境への `chezmoi apply` や、WSL2 のホームを対象にした `chezmoi add` / `re-add` は行わない。
- 共通設定の保存・同期は新しい `dotfiles` の `AGENTS.md` と対象一覧に従う。既存のスキルや設定は、個別の移行依頼なしに移動・削除しない。
- Arch での適用前には OS、source、destination と差分を確認する。リポジトリの運用文書は `.chezmoiignore` で配布対象から除外する。
- 未コミット変更を保全し、依頼対象だけをコミット・push する。設定の同期を他の作業の一括取り込みにしない。
