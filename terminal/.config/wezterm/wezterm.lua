local wezterm = require "wezterm"

return {
    font = wezterm.font_with_fallback {
        { family = "IosevkaTerm Nerd Font Mono", weight = "Medium" },
        { family = "Iosevka Nerd Font Mono", weight = "Medium" },
        "Fira Code",
        "Material Design Icons",
        "Noto Color Emoji",
    },
    warn_about_missing_glyphs = true,
    font_size = 13,

    -- Padding
    window_padding = {
        left = 20,
        right = 20,
        top = 20,
        bottom = 20,
    },

    -- Tab Bar
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    show_tab_index_in_tab_bar = true,

    -- General
    automatically_reload_config = true,
    window_background_opacity = 0.95,
    window_close_confirmation = "NeverPrompt",

    -- Coloscheme
    -- color_scheme = "Bright (base16)",
    color_scheme_dirs = {
        os.getenv "HOME" .. "/.config/decorator/output",
    },

    color_scheme = "Wezterm",

    -- History size
    scrollback_lines = 30000,

    -- Pretty Colors
    bold_brightens_ansi_colors = true,

    -- Keybinds
    keys = {
        {
            key = "d",
            mods = "SHIFT|ALT",
            action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } },
        },
        {
            key = "d",
            mods = "ALT",
            action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } },
        },
        {
            key = "q",
            mods = "CTRL|ALT",
            action = wezterm.action { CloseCurrentPane = { confirm = false } },
        },
        {
            key = "]",
            mods = "ALT",
            action = wezterm.action { ActivatePaneDirection = "Next" },
        },
        {
            key = "[",
            mods = "ALT",
            action = wezterm.action { ActivatePaneDirection = "Next" },
        },
    },
}
