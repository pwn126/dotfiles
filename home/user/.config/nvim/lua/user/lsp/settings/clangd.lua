return {
    cmd = {
        "clangd",
        "--background-index",
        "--all-scopes-completion",
        "--clang-tidy",
        "--header-insertion=never",
        "--cross-file-rename",
        "--limit-results=50",
        "--pch-storage=memory",
        "--log=verbose",
        "-j=5",
    }
}
