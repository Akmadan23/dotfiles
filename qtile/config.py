import os, re, socket, subprocess
from libqtile import qtile, layout, bar, widget, hook
from libqtile.lazy import lazy
from libqtile.config import Key, KeyChord, Screen, Group, Drag, Match

# Importing environment variables
home = os.environ["HOME"]
term = os.environ["TERMINAL"]
browser = os.environ["BROWSER"]

# Keys aliases
mod = "mod4"
alt = "mod1"
sft = "shift"
ctrl = "control"

# Font Awesome
awesome = "Font Awesome 6 Free Solid"

# Monokai Color Scheme (https://kolormark.com/brands/monokai)
colors = [
    "#000000", #0 - Black
    "#F92672", #1 - Magenta
    "#A6E22E", #2 - Green
    "#E6DB74", #3 - Yellow
    "#66D8EF", #4 - Blue
    "#FD971F", #5 - Orange
    "#AE81FF", #6 - Purple
    "#F8F8F0", #7 - White
    "#465457", #8 - Light Grey
    "#242424", #9 - Dark Grey
]

# Keyboard bindings
keys = [
    # Switch between windows
    Key([mod],              "h",        lazy.layout.left()),
    Key([mod],              "j",        lazy.layout.down()),
    Key([mod],              "k",        lazy.layout.up()),
    Key([mod],              "l",        lazy.layout.right()),

    # Move windows in current stack
    Key([mod, sft],         "h",        lazy.layout.shuffle_left()),
    Key([mod, sft],         "j",        lazy.layout.shuffle_down()),
    Key([mod, sft],         "k",        lazy.layout.shuffle_up()),
    Key([mod, sft],         "l",        lazy.layout.shuffle_right()),

    # Switch between monitors
    Key([mod],              "comma",    lazy.prev_screen()),
    Key([mod],              "period",   lazy.next_screen()),

    # Windows and layout behaviour
    Key([mod, sft],         "r",        lazy.restart()),
    Key([mod, sft],         "q",        lazy.window.kill()),
    Key([mod, sft],         "n",        lazy.layout.normalize()),
    Key([mod, sft],         "f",        lazy.window.toggle_floating()),
    Key([mod],              "plus",     lazy.layout.grow()),
    Key([mod],              "minus",    lazy.layout.shrink()),

    # Toggle between different layouts
    Key([mod],              "Tab",      lazy.next_layout()),
    Key([mod, sft],         "Tab",      lazy.prev_layout()),

    # Terminal and rofi
    Key([mod],              "Return",   lazy.spawn(term)),
    Key([mod],              "space",    lazy.spawn("rofi -modi drun,run -show drun")),
    Key([mod, sft],         "e",        lazy.spawn("rofi -modi x:~/.config/rofi/scripts/rofi-power-menu -show")),
    Key([mod, sft],         "x",        lazy.spawn("rofi -modi x:~/.config/rofi/scripts/rofi-xrandr-menu -show")),
    Key([mod, sft],         "d",        lazy.spawn("rofi -modi x:~/.config/rofi/scripts/rofi-dotfiles-menu -show")),

    # App spawning
    Key([mod],              "b",        lazy.spawn("blender")),
    Key([mod],              "f",        lazy.spawn("firefox")),
    Key([mod],              "x",        lazy.spawn("firefox -P extra")),
    Key([mod],              "c",        lazy.spawn("qalculate-gtk")),
    Key([mod],              "t",        lazy.spawn("thunderbird")),
    Key([mod],              "s",        lazy.spawn("flameshot gui")),
    Key([mod, sft],         "v",        lazy.spawn("clipmenu")),
    Key([mod],              "e",        lazy.spawn(f"{term} -t Ranger -e ranger")),

    # Volume and brightness controls
    Key([mod],              "Up",       lazy.spawn("dunsty amixer set Master unmute 5%+")), # +5% volume
    Key([mod],              "Down",     lazy.spawn("dunsty amixer set Master unmute 5%-")), # -5% volume
    Key([mod],              "m",        lazy.spawn("dunsty amixer set Master toggle")),     # mute
    Key([mod],              "Right",    lazy.spawn("xbacklight -inc 5 -steps 1")),          # +5% backlight
    Key([mod],              "Left",     lazy.spawn("xbacklight -dec 5 -steps 1")),          # -5% backlight
    Key([mod],              "r",        lazy.spawn("xbacklight -set 50")),                  # sets backlight to 50%

    # Moving cursor with keyboard
    Key([alt, ctrl],        "h",        lazy.spawn("xdotool mousemove_relative -- -4 0")),  # move left pointer 4px
    Key([alt, ctrl],        "j",        lazy.spawn("xdotool mousemove_relative -- 0 4")),   # move down pointer 4px
    Key([alt, ctrl],        "k",        lazy.spawn("xdotool mousemove_relative -- 0 -4")),  # move up pointer 4px
    Key([alt, ctrl],        "l",        lazy.spawn("xdotool mousemove_relative -- 4 0")),   # move right pointer 4px
    Key([alt],              "h",        lazy.spawn("xdotool mousemove_relative -- -64 0")), # move left pointer 64px
    Key([alt],              "j",        lazy.spawn("xdotool mousemove_relative -- 0 64")),  # move down pointer 64px
    Key([alt],              "k",        lazy.spawn("xdotool mousemove_relative -- 0 -64")), # move up pointer 64px
    Key([alt],              "l",        lazy.spawn("xdotool mousemove_relative -- 64 0")),  # move right pointer 64px
    Key([alt],              "b",        lazy.spawn("xdotool click 1")),                     # left click
    Key([alt],              "n",        lazy.spawn("xdotool click 2")),                     # center click
    Key([alt],              "m",        lazy.spawn("xdotool click 3")),                     # right click

    # Special keys
    Key([], "XF86MonBrightnessUp",      lazy.spawn("xbacklight -inc 5 -steps 1")),          # +5% backlight
    Key([], "XF86MonBrightnessDown",    lazy.spawn("xbacklight -dec 5 -steps 1")),          # -5% backlight
    Key([], "XF86AudioRaiseVolume",     lazy.spawn("dunsty amixer set Master unmute 5%+")), # +5% volume
    Key([], "XF86AudioLowerVolume",     lazy.spawn("dunsty amixer set Master unmute 5%-")), # -5% volume
    Key([], "XF86AudioMute",            lazy.spawn("dunsty amixer set Master toggle")),     # mute

    # Opening websites
    KeyChord([mod], "w", [
        Key([], "a", lazy.spawn(browser + " amazon.it")),
        Key([], "c", lazy.spawn(browser + " chess.com")),
        Key([], "d", lazy.spawn(browser + " duckduckgo.com")),
        Key([], "e", lazy.spawn(browser + " ebay.it")),
        Key([], "f", lazy.spawn(browser + " flathub.com")),
        Key([], "g", lazy.spawn(browser + " github.com")),
        Key([], "r", lazy.spawn(browser + " reddit.com")),
        Key([], "o", lazy.spawn(browser + " odysee.com")),
        Key([], "t", lazy.spawn(browser + " twitch.tv")),
        Key([], "w", lazy.spawn(browser + " wikipedia.com")),
        Key([], "y", lazy.spawn(browser + " youtube.com")),
    ]),

    # Set volume
    KeyChord([mod], "v", [
        Key([], str(i), lazy.spawn(f"amixer set Master {str(i)}0%")) for i in range(1, 10)
    ]),
]

# Mouse bindings
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start = lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),     start = lazy.window.get_size()),
]

#          1    2    3    4    5    6    7    8    9
labels = ["", "", "", "", "", "", "", "", ""]
groups = [Group(name = str(i), label = labels[i - 1]) for i in range(1, 10)]

for i in groups:
    keys.extend([
        Key([mod],          i.name, lazy.group[i.name].toscreen()),
        Key([mod, sft],     i.name, lazy.window.togroup(i.name, switch_group = True)),
        Key([mod, ctrl],    i.name, lazy.window.togroup(i.name, switch_group = False)),
    ])

# Default layout theme
layout_theme = dict(
    border_normal = colors[0],
    border_focus = colors[3],
    border_width = 2,
    single_border_width = 0,
    margin = 8,
    single_margin = 0,
)

layouts = [
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Floating(),
    # layout.Matrix(),    
    # layout.Max(),
    # layout.RatioTile(),
    # layout.Slice(),
    # layout.Stack(),
    # layout.Tile(),
    # layout.VerticalTile(),
    # layout.Zoomy(),

    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme, ratio = 0.6),

    layout.TreeTab(
        font = "Cantarell bold",
        font_size = 12,
        border_width = 0,
        panel_width = 128,
        margin_left = 0,
        padding_left = 0,
        section_padding = 0,
        bg_color = colors[0],
        active_fg = colors[0],
        active_bg = colors[3],
        inactive_fg = colors[7],
        inactive_bg = colors[8],
        urgent_fg = colors[7],
        urgent_bg = colors[1],
    ),
]

floating_layout = layout.Floating(
    border_focus = colors[4],
    border_normal = colors[0],
    border_width = 2,

    float_rules = [
        *layout.Floating.default_float_rules,   # Defaults
        Match(wm_class = "lxpolkit"),           # Authentication windows
        Match(wm_class = "Calendar"),           # Thunderbird calendar window
        Match(wm_class = "Msgcompose"),         # Thunderbird message window
        Match(wm_class = "qalculate-gtk"),      # Qalculate
    ]
)

widget_defaults = dict(
    font = "Cantarell Bold",
    fontsize = 14,
    padding = 4,
)

extension_defaults = widget_defaults.copy()

# Separator defaults
separator = dict(
    text = "",
    fontsize = 24,
    padding = 0,
    margin = 0
)

# Groupbox defaults
groupbox = dict(
    font = awesome,
    active = colors[7],
    inactive = colors[8],
    urgent_border = colors[5],
    this_screen_border = colors[4],
    this_current_screen_border = colors[4],
    other_screen_border = colors[8],
    other_current_screen_border = colors[8],
    highlight_color = [colors[0], colors[4]],
    highlight_method = "line",
)

# Windowname defaults
windowname = dict(
    format = "{name}",
    font = "Cantarell Bold",
)

# Screen settings
screens = [
    Screen(
        top = bar.Bar(
            widgets = [
                widget.GroupBox(**groupbox),
                widget.WindowName(**windowname),

                widget.TextBox(
                    **separator,
                    background = colors[0],
                    foreground = colors[1],
                ),

                widget.TextBox(
                    **separator,
                    background = colors[1],
                    foreground = colors[2],
                ),

                widget.TextBox(
                    text = "",
                    font = awesome,
                    fontsize = 12,
                    background = colors[2],
                    foreground = colors[0],
                ),

                widget.CheckUpdates(
                    distro = "Arch",
                    update_interval = 600,
                    no_update_string = "✔",
                    display_format = "{updates}",
                    execute = f"{term} --hold -e paru",
                    colour_have_updates = colors[0],
                    colour_no_updates = colors[0],
                    background = colors[2],
                    foreground = colors[0],
                ),

                widget.TextBox(
                    **separator,
                    background = colors[2],
                    foreground = colors[3],
                ),

                widget.TextBox(
                    text = "",
                    font = awesome,
                    background = colors[3],
                    foreground = colors[0],
                ),

                widget.Memory(
                    format = "{MemUsed: .2f}/{MemTotal: .0f} GB",
                    measure_mem = "G",
                    update_interval = 2,
                    background = colors[3],
                    foreground = colors[0],
                ),

                widget.TextBox(
                    **separator,
                    background = colors[3],
                    foreground = colors[4],
                ),

                widget.TextBox(
                    text = "",
                    font = awesome,
                    background = colors[4],
                    foreground = colors[0],
                ),

                widget.ThermalSensor(
                    update_interval = 2,
                    foreground_alert = colors[1],
                    threshold = 90,
                    background = colors[4],
                    foreground = colors[0],
                ),

                widget.TextBox(
                    **separator,
                    background = colors[4],
                    foreground = colors[5],
                ),

                widget.TextBox(
                    text = "",
                    font = awesome,
                    background = colors[5],
                    foreground = colors[0],
                ),

                widget.Backlight(
                    backlight_name = "intel_backlight",
                    brightness_file = "brightness",
                    change_command = None,
                    background = colors[5],
                    foreground = colors[0],
                ),

                widget.TextBox(
                    **separator,
                    background = colors[5],
                    foreground = colors[6],
                ),

                widget.TextBox(
                    text = "",
                    font = awesome,
                    background = colors[6],
                    foreground = colors[0],
                ),

                widget.Volume(
                    step = 5,
                    background = colors[6],
                    foreground = colors[0],
                ),

                widget.TextBox(
                    **separator,
                    background = colors[6],
                    foreground = colors[8],
                ),

                widget.TextBox(
                    text = "",
                    font = awesome,
                    fontsize = 16,
                    background = colors[8],
                    foreground = colors[7],
                ),

                widget.Battery(
                    format = "{char}{percent:1.0%}",
                    charge_char = " ",
                    discharge_char = "",
                    unknown_char = "",
                    full_char = "",
                    show_short_text = False,
                    update_interval = 30,
                    notify_below = 20,
                    notification_timeout = 0,
                    low_percentage = 0.2,
                    low_foreground = colors[1],
                    background = colors[8],
                    foreground = colors[7],
                ),

                widget.TextBox(
                    **separator,
                    background = colors[8],
                    foreground = colors[9],
                ),

                widget.TextBox(
                    text = "",
                    font = awesome,
                    fontsize = 12,
                    background = colors[9],
                    foreground = colors[7],
                ),

                widget.Clock(
                    format = "%A %d %B, %H:%M",
                    background = colors[9],
                    foreground = colors[7],
                    mouse_callbacks = dict(Button1 = lazy.spawn("gsimplecal"))
                ),

                widget.TextBox(
                    **separator,
                    background = colors[9],
                    foreground = colors[0],
                ),

                widget.Systray(),
                widget.CurrentLayoutIcon(scale = 0.75),
            ],

            size = 22,
            background = colors[0],
        )
    ),

    Screen(
        top = bar.Bar(
            widgets = [
                widget.GroupBox(**groupbox),
                widget.WindowName(**windowname),
                widget.TextBox(**separator, background = colors[0], foreground = colors[1]),
                widget.TextBox(**separator, background = colors[1], foreground = colors[2]),
                widget.TextBox(**separator, background = colors[2], foreground = colors[3]),
                widget.TextBox(**separator, background = colors[3], foreground = colors[4]),
                widget.TextBox(**separator, background = colors[4], foreground = colors[5]),
                widget.TextBox(**separator, background = colors[5], foreground = colors[6]),
                widget.TextBox(**separator, background = colors[6], foreground = colors[8]),
                widget.TextBox(**separator, background = colors[8], foreground = colors[9]),
                widget.Clock(format = "%A %d %B, %H:%M", background = colors[9], foreground = colors[7]),
                widget.TextBox(**separator, background = colors[9], foreground = colors[0]),
                widget.CurrentLayoutIcon(scale = 0.75),
            ],

            size = 24,
            background = colors[0],
        )
    )
]

# Other settings
cursor_warp         = False
auto_fullscreen     = True
bring_front_click   = False
follow_mouse_focus  = True
reconfigure_screens = True

# neofetch fixes
wmname = "Qtile"
dename = ""

# Monitor detection script
@hook.subscribe.startup_once
def autostart_once():
    subprocess.call([home + "/.config/qtile/monitordetection.sh"])

# Autostart script
@hook.subscribe.startup
def autostart():
    subprocess.call([home + "/.config/qtile/autostart.sh"])
