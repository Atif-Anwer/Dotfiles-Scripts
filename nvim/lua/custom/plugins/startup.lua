-- https://github.com/startup-nvim/startup.nvim

return {
  "startup-nvim/startup.nvim",
  version = "*",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    --require("startup").setup({theme = "evil"})
  require("startup").setup({theme = "dashboard"}) -- put theme name here
	end
}
