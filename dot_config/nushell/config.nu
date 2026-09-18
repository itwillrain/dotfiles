# Shared Nushell configuration.
use ($nu.default-config-dir | path join "mise.nu")

$env.config.buffer_editor = "nvim"

# Powerlevel10k-style prompt via Oh My Posh.
oh-my-posh init nu --config ($nu.default-config-dir | path join "powerlevel10k_lean.omp.json")
