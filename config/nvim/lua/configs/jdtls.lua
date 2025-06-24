return function()
    -- Custom paths
    local path = {
        jar = "/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
        config = "/usr/share/java/jdtls/config_linux",
        data = os.getenv("ECLIPSE_WORKSPACE"),
    }

    -- Initialize JDTLS
    require("jdtls").start_or_attach {
        cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xms1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",

            "-jar",             path.jar,
            "-configuration",   path.config,
            "-data",            path.data,
        },

        -- This is the default if not provided, you can remove it. Or adjust as needed.
        -- One dedicated LSP server & client will be started per unique root_dir
        root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew" },
    }
end
