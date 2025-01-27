local server = require "nvim-lsp-installer.server"
local npm = require "nvim-lsp-installer.installers.npm"
local Data = require "nvim-lsp-installer.data"
local context = require "nvim-lsp-installer.installers.context"

return function(name, root_dir)
    return server.Server:new {
        name = name,
        root_dir = root_dir,
        installer = {
            context.set(function(ctx)
                ctx.requested_server_version = Data.coalesce(
                    ctx.requested_server_version,
                    "10.0.7-nightly.2021.7.2" -- https://github.com/rome/tools/pull/1409
                )
            end),
            npm.packages { "rome" },
        },
        default_options = {
            cmd = { npm.executable(root_dir, "rome"), "lsp" },
        },
    }
end
