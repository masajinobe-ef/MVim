return {{
    -- dashboard-nvim
    "nvimdev/dashboard-nvim",
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    opts = function()
        local logo = [[
        ███╗   ███╗ █████╗ ███████╗ █████╗      ██╗██╗███╗   ██╗ ██████╗ ██████╗ ███████╗
        ████╗ ████║██╔══██╗██╔════╝██╔══██╗     ██║██║████╗  ██║██╔═══██╗██╔══██╗██╔════╝
        ██╔████╔██║███████║███████╗███████║     ██║██║██╔██╗ ██║██║   ██║██████╔╝█████╗  
        ██║╚██╔╝██║██╔══██║╚════██║██╔══██║██   ██║██║██║╚██╗██║██║   ██║██╔══██╗██╔══╝  
        ██║ ╚═╝ ██║██║  ██║███████║██║  ██║╚█████╔╝██║██║ ╚████║╚██████╔╝██████╔╝███████╗
        ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚══════╝
    ]]

        logo = string.rep("\n", 8) .. logo .. "\n\n"

        local opts = {
            theme = "doom",
            hide = {
                -- this is taken care of by lualine
                -- enabling this messes up the actual laststatus setting after loading a file
                statusline = false
            },
            config = {
                header = vim.split(logo, "\n"),
                -- stylua: ignore
                center = {{
                    action = 'lua LazyVim.pick()()',
                    desc = " Find File",
                    icon = " ",
                    key = "f"
                }, {
                    action = "ene | startinsert",
                    desc = " New File",
                    icon = " ",
                    key = "n"
                }, {
                    action = 'lua LazyVim.pick("oldfiles")()',
                    desc = " Recent Files",
                    icon = " ",
                    key = "r"
                }, {
                    action = 'lua LazyVim.pick("live_grep")()',
                    desc = " Find Text",
                    icon = " ",
                    key = "g"
                }, {
                    action = 'lua LazyVim.pick.config_files()()',
                    desc = " Config",
                    icon = " ",
                    key = "c"
                }, {
                    action = 'lua require("persistence").load()',
                    desc = " Restore Session",
                    icon = " ",
                    key = "s"
                }, {
                    action = "LazyExtras",
                    desc = " Lazy Extras",
                    icon = " ",
                    key = "x"
                }, {
                    action = "Lazy",
                    desc = " Lazy",
                    icon = "󰒲 ",
                    key = "l"
                }, {
                    action = function()
                        vim.api.nvim_input("<cmd>qa<cr>")
                    end,
                    desc = " Quit",
                    icon = " ",
                    key = "q"
                }},
                footer = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    return {"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"}
                end
            }
        }

        for _, button in ipairs(opts.config.center) do
            button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
            button.key_format = "  %s"
        end

        -- open dashboard after closing lazy
        if vim.o.filetype == "lazy" then
            vim.api.nvim_create_autocmd("WinClosed", {
                pattern = tostring(vim.api.nvim_get_current_win()),
                once = true,
                callback = function()
                    vim.schedule(function()
                        vim.api.nvim_exec_autocmds("UIEnter", {
                            group = "dashboard"
                        })
                    end)
                end
            })
        end

        return opts
    end
}, -- lualine.nvim
{
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
        options = {
            theme = "solarized_dark"
        }
    }
}, -- bufferline.nvim
{
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {{
        "<Tab>",
        "<Cmd>BufferLineCycleNext<CR>",
        desc = "Next tab"
    }, {
        "<S-Tab>",
        "<Cmd>BufferLineCyclePrev<CR>",
        desc = "Prev tab"
    }},
    opts = {
        options = {
            mode = "tabs",
            show_buffer_close_icons = false,
            show_close_icon = false
        }
    }
}, -- nvim-notify
{
    "rcarriga/nvim-notify",
    opts = {
        timeout = 10000
    }
}, -- noice.nvim
{
    "folke/noice.nvim",
    opts = function(_, opts)
        opts.presets.lsp_doc_border = true
        table.insert(opts.routes, {
            filter = {
                event = "notify",
                find = "No information available"
            },
            opts = {
                skip = true
            }
        })
    end
}, -- mini.animate
{
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
        opts.scroll = {
            enable = false
        }
    end
}, -- incline.nvim 
{
    "b0o/incline.nvim",
    dependencies = {"craftzdog/solarized-osaka.nvim"},
    event = "BufReadPre",
    priority = 1200,
    config = function()
        local colors = require("solarized-osaka.colors").setup()
        require("incline").setup({
            highlight = {
                groups = {
                    InclineNormal = {
                        guibg = colors.magenta500,
                        guifg = colors.base04
                    },
                    InclineNormalNC = {
                        guifg = colors.violet500,
                        guibg = colors.base03
                    }
                }
            },
            window = {
                margin = {
                    vertical = 0,
                    horizontal = 1
                }
            },
            hide = {
                cursorline = true
            },
            render = function(props)
                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                if vim.bo[props.buf].modified then
                    filename = "[+] " .. filename
                end

                local icon, color = require("nvim-web-devicons").get_icon_color(filename)
                return {{
                    icon,
                    guifg = color
                }, {" "}, {filename}}
            end
        })
    end
}}
