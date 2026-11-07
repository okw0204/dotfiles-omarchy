-- Arch/Omarchy 固有の設定。共通の options.lua から options.local.lua として重ねて読み込まれる。
-- ターミナルの OSC 52 経由でリモートの Neovim からクリップボードへコピーする。
require("config.remote_clipboard").setup()
