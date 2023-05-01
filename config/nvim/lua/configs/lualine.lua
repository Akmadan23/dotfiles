return function()
    -- custom colors
    local colors = {
        black   = "#272822",
        gray    = "#465457",
        white   = "#F8F8F0",
        magenta = "#F92672",
        green   = "#A6E22E",
        yellow  = "#E6DB74",
        blue    = "#66D9EF",
        orange  = "#FD971F",
        purple  = "#AE81FF",
    }

    -- Change filename module's color when the file is modified
    local filename_color = function()
        if vim.bo.modified then
            return {
                fg = colors.magenta,
                gui = "bold",
            }
        else
            return nil
        end
    end

    -- Define options and sections
    require("lualine").setup {
        options = {
            section_separators      = { left = "", right = "" },
            component_separators    = { left = "", right = "" },

            theme = {
                normal = {
                    a = { fg = colors.black, bg = colors.yellow, gui = "bold"   },
                    b = { fg = colors.white, bg = colors.black                  },
                    c = { fg = colors.white, bg = colors.gray                   },
                },

                insert      = { a = { fg = colors.black,  bg = colors.blue,     gui = "bold" } },
                visual      = { a = { fg = colors.black,  bg = colors.green,    gui = "bold" } },
                replace     = { a = { fg = colors.black,  bg = colors.magenta,  gui = "bold" } },
                command     = { a = { fg = colors.black,  bg = colors.orange,   gui = "bold" } },
                terminal    = { a = { fg = colors.black,  bg = colors.purple,   gui = "bold" } },
                inactive    = { c = { fg = colors.yellow, bg = colors.gray                   } },
            }
        },

        sections = {
            lualine_a = { "mode"                                                        },
            lualine_b = { { "filename", newfile_status = true, color = filename_color } },
            lualine_c = { "branch", "diff", { "diagnostics", sources = { "nvim_lsp" } } },
            lualine_x = { { "filetype", colored = false }                               },
            lualine_y = { "encoding"                                                    },
            lualine_z = { "progress", "location"                                        },
        },

        inactive_winbar = {
            lualine_c = { "filename" },
            lualine_x = { { "filetype", colored = false }, "location" },
        }
    }
end
