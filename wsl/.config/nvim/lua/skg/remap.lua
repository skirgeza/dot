vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ bufnr = 0 })
end)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Function to create a new python file, add shebang and make it executable
vim.keymap.set("n", "<leader>np", function()
  local netrw_dir = vim.fn.expand("%:p:h") -- Get the directory netrw is showing

  vim.ui.input({ prompt = "New Python file name?: " }, function(input)
    if input == nil or input == "" then return end
    local filename = input .. ".py"
    local fullpath = netrw_dir .. "/" .. filename

    -- Write the shebang line
    local file = io.open(fullpath, "w")
    if file then
      file:write("#!/usr/bin/env python3\n")
      file:close()

      -- Optional: make it executable (Unix-only)
      vim.fn.system({ "chmod", "+x", fullpath })

      -- Refresh netrw and optionally open the file
      vim.cmd("edit .") -- refresh netrw
      vim.cmd("edit " .. fullpath) -- comment out if you don't want to open the file
    else
      print("Failed to create file: " .. fullpath)
    end
  end)
end, { desc = "Create new Python file with shebang and refresh netrw" })
