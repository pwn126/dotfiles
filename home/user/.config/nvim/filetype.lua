vim.filetype.add({
    extension = {
        Jenkinsfile = "groovy",
        bb = "bash",
        bbappend = "bash",
        bbclass = "bash",
    },
    pattern = {
        ["~/src/images/.*/.*%.inc"] = "bash",
        ["~/src/images/.*/.*%.conf"] = "bash",
    },
})
