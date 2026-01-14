return {
  "mfussenegger/nvim-dap",
  -- 依存関係は以前のステップで mason-dap.lua に分離していることを前提
  opts = function(_, opts)
    local dap = require("dap")

    -- LazyVimの設定が既に存在するため、新しい設定を追加する
    if not dap.configurations.javascript then
      dap.configurations.javascript = {}
    end

    -- 1. Jest テストデバッグ設定の追加 (type: node)
    table.insert(dap.configurations.javascript, {
      type = "node",
      request = "launch",
      name = "Debug Jest Test (Current File)",
      runtimeExecutable = "npm", -- または 'yarn', 'pnpm' を使用
      runtimeArgs = {
        "test",
        "--",
        "${file}",
        "--runInBand", -- デバッグ時に必須 (テストを直列で実行)
      },
      console = "integratedTerminal", -- Neovimの統合ターミナルで実行結果を表示
      protocol = "inspector",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      timeout = 60000,
    })

    -- 2. ブラウザデバッグ設定の追加 (type: pwa-chrome/msedge)
    table.insert(dap.configurations.javascript, {
      type = "pwa-chrome", -- または "pwa-msedge"
      request = "attach",
      name = "Attach to Browser (Chrome/Edge)",
      port = 9222,
      webRoot = "${workspaceFolder}",
      timeout = 30000,
    })

    -- TypeScript にも同じ設定を適用 (LazyVimの標準動作に倣う)
    dap.configurations.typescript = dap.configurations.javascript
  end,
}
