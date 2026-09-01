# Let bat follow the terminal's color scheme.
#
# "ansi" defers entirely to the terminal's ANSI palette — Ghostty's theme
# controls the actual colors, bat makes no truecolor decisions.
# This is the most faithful "follow Ghostty" option.
export BAT_THEME="ansi"

# If you want richer syntax highlighting (more than 8 colors) but still
# want dark/light to track Ghostty's background automatically, use auto
# instead and specify which bat themes to use per mode:
#
# export BAT_THEME="auto"
# export BAT_THEME_DARK="Monokai Extended"
# export BAT_THEME_LIGHT="Monokai Extended Light"

export BAT_STYLE="numbers,changes,header"
