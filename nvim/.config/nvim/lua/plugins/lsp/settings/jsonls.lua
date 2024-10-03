return {
    settings = {
        json = {
            validate = { enable = true },
            schemas = {
                {
                    description = "aptiv-network-manager on Mac",
                    fileMatch = { "config.json" },
                    folderUri = "/Users/philip/src/aptiv-network-manager/sets.d",
                    url = "file:///Users/philip/src/aptiv-network-manager/sets.d/schema.json",
                },
                {
                    description = "aptiv-network-manager for Work",
                    fileMatch = { "config.json" },
                    folderUri = "/home/user/src/mwd_internal/over-the-air/aptiv-network-manager/sets.d",
                    url = "file:///home/user/src/mwd_internal/over-the-air/aptiv-network-manager/sets.d/schema.json",
                },
                {
                    description = "UCM SW package",
                    fileMatch = { "manifest.json" },
                    folderUri = "/home/user/src/mwd_internal/over-the-air/ucm/ucm-service/configs/pkg-manifests/swpkg",
                    url = "file:///home/user/src/mwd_internal/over-the-air/ucm/ucm-service/configs/pkg-manifests/swpkg/schema.json",
                },
                {
                    description = "UCM SW cluster",
                    fileMatch = { "manifest.json" },
                    folderUri = "/home/user/src/mwd_internal/over-the-air/ucm/ucm-service/configs/pkg-manifests/swcl",
                    url = "file:///home/user/src/mwd_internal/over-the-air/ucm/ucm-service/configs/pkg-manifests/swcl/schema.json",
                },
                {
                    description = "UCM config",
                    fileMatch = { "ucm.json" },
                    folderUri = "/home/user/src/mwd_internal/over-the-air/ucm-amt/ucm-service/configs/ucm-config",
                    url = "file:///home/user/src/mwd_internal/over-the-air/ucm-amt/ucm-service/configs/ucm-config/ucm.schema.json",
                },
            },
        },
    },
}
