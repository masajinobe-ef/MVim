return {{
    "craftzdog/solarized-osaka.nvim",
    branch = "osaka",
    lazy = false,
    priority = 1000,
    opts = function()
        return {
            transparent = true
        }
    end
}, {
    "LazyVim/LazyVim",
    opts = {
        colorscheme = "solarized-osaka"
    }
}}
