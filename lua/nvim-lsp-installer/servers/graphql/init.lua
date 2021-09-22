local server = require "nvim-lsp-installer.server"
local npm = require "nvim-lsp-installer.installers.npm"

return function(name, root_dir)
    return server.Server:new {
        name = name,
        root_dir = root_dir,
        installer = npm.packages { "graphql-language-service-cli@latest", "graphql" },
        get_latest_available_packages = function(callback)
            callback {
                { "graphql-language-service-cli", "3.2.1" },
                { "graphql", "17.0.3" },
            }
        end,
        default_options = {
            cmd = { npm.executable(root_dir, "graphql-lsp"), "server", "-m", "stream" },
            filetypes = { "typescriptreact", "javascriptreact", "graphql" },
        },
    }
end
