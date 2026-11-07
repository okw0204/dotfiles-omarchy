-- ターミナルの OSC 52 経由でシステムクリップボードへコピーする。
-- ターミナル側の許可設定（例: alacritty の osc52、tmux の set-clipboard）が必要。
local M = {}

function M.setup()
  vim.g.clipboard = "osc52"
end

return M
