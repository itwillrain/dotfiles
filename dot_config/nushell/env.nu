# Shared environment for Nushell.
let mise_path = $nu.default-config-dir | path join "mise.nu"
^mise activate nu | save $mise_path --force

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
