return function()
    -- Custom colors
    local c = require("colorschemes").monokai

    -- Change filename module's color when the file is modified
    local filename_color = function()
        if vim.bo.modified then
            return {
                fg = c.magenta,
                gui = "bold",
            }
        end
    end

    local title = function(name)
        return function()
            return name
        end
    end

    local nvim_tree_cwd = function()
        local cwd = require("nvim-tree.core").get_cwd()
        return vim.fn.fnamemodify(cwd, ":~")
    end

    local telescope_prompt_title = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local status = require("telescope.state").get_status(bufnr)
        return status.picker.prompt_title
    end

    -- Custom extensions
    local ext = {
        nvim_tree = {
            sections = {
                lualine_a = { title("NvimTree") },
                lualine_b = { nvim_tree_cwd },
            },

            filetypes = { "NvimTree" }
        },

        telescope = {
            sections = {
                lualine_a = { title("Telescope") },
                lualine_b = { telescope_prompt_title },
            },

            filetypes = { "TelescopePrompt" }
        }
    }

    -- Define options and sections
    require("lualine").setup {
        options = {
            globalstatus = true,
            section_separators      = { left = "", right = "" },
            component_separators    = { left = "", right = "" },

            theme = {
                normal = {
                    a = { fg = c.bg1, bg = c.yellow, gui = "bold" },
                    b = { fg = c.fg1, bg = c.bg1 },
                    c = { fg = c.fg1, bg = c.grey }
                },

                insert = {
                    a = { fg = c.bg1, bg = c.blue, gui = "bold" }
                },

                visual = {
                    a = { fg = c.bg1, bg = c.green, gui = "bold" }
                },

                replace = {
                    a = { fg = c.bg1, bg = c.magenta, gui = "bold" }
                },

                command = {
                    a = { fg = c.bg1, bg = c.orange, gui = "bold" }
                },

                terminal = {
                    a = { fg = c.bg1, bg = c.purple, gui = "bold" }
                },

                inactive = {
                    c = { fg = c.yellow, bg = c.grey }
                }
            }
        },

        sections = {
            lualine_a = {
                "mode"
            },

            lualine_b = {
                { "filename", newfile_status = true, color = filename_color }
            },

            lualine_c = {
                "branch",
                "diff",
                { "diagnostics", sources = { "nvim_lsp" } }
            },

            lualine_x = {
                { "filetype", colored = false }
            },

            lualine_y = {
                "encoding"
            },

            lualine_z = {
                "progress",
                "location"
            }
        },

        inactive_winbar = {
            lualine_c = {
                "filename"
            },

            lualine_x = {
                { "filetype", colored = false }
            }
        },

        extensions = {
            ext.nvim_tree,
            ext.telescope,
            "lazy",
            "man",
            "trouble",
        }
    }
end
