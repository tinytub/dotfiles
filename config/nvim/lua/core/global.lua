local global = {}

function global.neovide_config()
    vim.cmd [[set guifont=JetBrainsMonoNL\ Nerd\ Font:h14]]
    --vim.cmd [[set guifont=Input\ Nerd\ Font:h14]]
    --opt.guifont = "JetBrainsMono Nerd Font Mono"
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_cursor_vfx_mode = "railgun"
    --vim.g.neovide_cursor_vfx_mode = "ripple"
    --vim.g.neovide_no_idle = true
    vim.g.neovide_cursor_animation_length = 0.03
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_cursor_trail_length = 0.05
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_vfx_opacity = 200.0
    vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
    vim.g.neovide_cursor_vfx_particle_speed = 20.0
    vim.g.neovide_cursor_vfx_particle_density = 5.0
end

global.neovide_config()

return global
