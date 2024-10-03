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
            },
        },
    },
}
