# pyright: reportPrivateImportUsage = false
import os, hooks as _
from libqtile import layout, widget
from libqtile.lazy import lazy
from libqtile.config import Bar, Drag, Group, Key, KeyChord, Match, Screen

# Keys aliases
mod = "mod4"
alt = "mod1"
sft = "shift"
ctrl = "control"

# Import environment variables
term = os.environ["TERMINAL"]

# Font Awesome
awesome = "Font Awesome 6 Free Solid"

# Monokai Color Scheme
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
    Key([mod],          "h",        lazy.layout.left()),
    Key([mod],          "j",        lazy.layout.down()),
    Key([mod],          "k",        lazy.layout.up()),
    Key([mod],          "l",        lazy.layout.right()),

    # Move windows in current stack
    Key([mod, sft],     "h",        lazy.layout.shuffle_left()),
    Key([mod, sft],     "j",        lazy.layout.shuffle_down()),
    Key([mod, sft],     "k",        lazy.layout.shuffle_up()),
    Key([mod, sft],     "l",        lazy.layout.shuffle_right()),

    # Grow windows
    Key([mod, ctrl],    "h",        lazy.layout.grow_left()),
    Key([mod, ctrl],    "j",        lazy.layout.grow_down()),
    Key([mod, ctrl],    "k",        lazy.layout.grow_up()),
    Key([mod, ctrl],    "l",        lazy.layout.grow_right()),

    # Windows and layout behaviour
    Key([mod, sft],     "r",        lazy.restart()),
    Key([mod, sft],     "q",        lazy.window.kill()),
    Key([mod, sft],     "m",        lazy.window.toggle_minimize()),
    Key([mod, sft],     "f",        lazy.window.toggle_floating()),
    Key([mod, sft],     "s",        lazy.layout.toggle_split()),
    Key([mod, sft],     "n",        lazy.layout.normalize()),

    # Switch between monitors
    Key([mod],          "comma",    lazy.prev_screen()),
    Key([mod],          "period",   lazy.next_screen()),

    # Toggle between different layouts
    Key([mod],          "Tab",      lazy.next_layout()),
    Key([mod, sft],     "Tab",      lazy.prev_layout()),

    # Terminal and rofi
    Key([mod],          "Return",   lazy.spawn(term)),
    Key([mod],          "space",    lazy.spawn("rofi -modi drun,run -show drun")),
    Key([mod, sft],     "e",        lazy.spawn("rofi -modi x:~/.config/rofi/scripts/rofi-power-menu -show")),
    Key([mod, sft],     "x",        lazy.spawn("rofi -modi x:~/.config/rofi/scripts/rofi-xrandr-menu -show")),
    Key([mod, sft],     "d",        lazy.spawn("rofi -modi x:~/.config/rofi/scripts/rofi-dotfiles-menu -show")),

    # App spawning
    Key([mod],          "f",        lazy.spawn("firefox")),
    Key([mod],          "x",        lazy.spawn("firefox -P extra")),
    Key([mod],          "c",        lazy.spawn("qalculate-gtk")),
    Key([mod],          "s",        lazy.spawn("flameshot gui")),
    Key([mod, sft],     "v",        lazy.spawn("clipmenu")),
    Key([mod],          "e",        lazy.spawn(f"{term} -t Ranger -e ranger")),

    # Volume and brightness controls
    Key([mod],          "Up",       lazy.spawn("amixer set Master unmute 5%+")),        # +5% volume
    Key([mod],          "Down",     lazy.spawn("amixer set Master unmute 5%-")),        # -5% volume
    Key([mod],          "m",        lazy.spawn("amixer set Master toggle")),            # mute
    Key([mod],          "Right",    lazy.spawn("xbacklight -inc 5 -steps 1")),          # +5% backlight
    Key([mod],          "Left",     lazy.spawn("xbacklight -dec 5 -steps 1")),          # -5% backlight
    Key([mod],          "r",        lazy.spawn("xbacklight -set 50")),                  # sets backlight to 50%

    # Move with keyboard
    Key([alt, ctrl],    "h",        lazy.spawn("xdotool mousemove_relative -- -4 0")),  # move pointer 4px left
    Key([alt, ctrl],    "j",        lazy.spawn("xdotool mousemove_relative -- 0 4")),   # move pointer 4px down
    Key([alt, ctrl],    "k",        lazy.spawn("xdotool mousemove_relative -- 0 -4")),  # move pointer 4px up
    Key([alt, ctrl],    "l",        lazy.spawn("xdotool mousemove_relative -- 4 0")),   # move pointer 4px right
    Key([alt],          "h",        lazy.spawn("xdotool mousemove_relative -- -64 0")), # move pointer 64px left
    Key([alt],          "j",        lazy.spawn("xdotool mousemove_relative -- 0 64")),  # move pointer 64px down
    Key([alt],          "k",        lazy.spawn("xdotool mousemove_relative -- 0 -64")), # move pointer 64px up
    Key([alt],          "l",        lazy.spawn("xdotool mousemove_relative -- 64 0")),  # move pointer 64px right
    Key([alt],          "b",        lazy.spawn("xdotool click 1")),                     # left click
    Key([alt],          "n",        lazy.spawn("xdotool click 2")),                     # center click
    Key([alt],          "m",        lazy.spawn("xdotool click 3")),                     # right click

    # Special keys
    Key([], "XF86MonBrightnessUp",      lazy.spawn("xbacklight -inc 5 -steps 1")),      # +5% backlight
    Key([], "XF86MonBrightnessDown",    lazy.spawn("xbacklight -dec 5 -steps 1")),      # -5% backlight
    Key([], "XF86AudioRaiseVolume",     lazy.spawn("amixer set Master unmute 5%+")),    # +5% volume
    Key([], "XF86AudioLowerVolume",     lazy.spawn("amixer set Master unmute 5%-")),    # -5% volume
    Key([], "XF86AudioMute",            lazy.spawn("amixer set Master toggle")),        # mute

    # Set volume
    KeyChord([mod], "v", [Key([], str(i), lazy.spawn(f"amixer set Master {i}0%")) for i in range(1, 10)]),

    # Set brightness
    KeyChord([mod], "b", [Key([], str(i), lazy.spawn(f"xbacklight -set {i}0")) for i in range(1, 10)]),
]

# Mouse bindings
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start = lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),     start = lazy.window.get_size()),
]

#                1    2    3    4    5    6    7    8    9
labels = [None, "", "", "", "", "", "", "", "", ""]
groups = [Group(name = str(i), label = labels[i]) for i in range(1, 10)]

for g in groups:
    keys.extend([
        Key([mod],          g.name, lazy.group[g.name].toscreen()),
        Key([mod, sft],     g.name, lazy.window.togroup(g.name, switch_group = True)),
        Key([mod, ctrl],    g.name, lazy.window.togroup(g.name, switch_group = False)),
    ])

# Layouts list
layouts = [
    layout.Columns(
        border_normal = colors[0],
        border_normal_stack = colors[0],
        border_focus = colors[4],
        border_focus_stack = colors[1],
        border_width = 2,
        margin = 4,
        margin_on_single = 0,
        num_columns = 2,
        insert_position = 1
    ),
    layout.Max(),
]

floating_layout = layout.Floating(
    border_focus = colors[3],
    border_normal = colors[0],
    border_width = 2,

    float_rules = [
        *layout.Floating.default_float_rules,   # Defaults
        Match(wm_class = "lxpolkit"),           # Authentication windows
        Match(wm_class = "Calendar"),           # Thunderbird calendar window
        Match(wm_class = "Msgcompose"),         # Thunderbird message window
        Match(wm_class = "pinentry-gtk-2"),     # GPG passphrase prompt
        Match(wm_class = "qalculate-gtk"),      # Qalculate
    ]
)

# Widget defaults
widget_defaults = dict(
    font = "Cantarell Bold",
    fontsize = 14,
    padding = 4,
)

# Separator defaults
sep = dict(
    text = "",
    font = "Hasklug Nerd Font Mono",
    fontsize = 22,
    padding = 0,
    margin = 0
)

# GroupBox defaults
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

# TaskList defaults
tasklist = dict(
    font = "Cantarell",
    margin = 0,
    border = None,
    icon_size = 16,
    title_width_method = "uniform",
    markup_focused = "<b>{}</b>",
    markup_floating = "[F] {}",
)

# Widgets list for primary monitor
widgets1 = [
    widget.GroupBox(**groupbox),
    widget.TaskList(**tasklist),

    widget.TextBox(
        **sep,
        background = colors[0],
        foreground = colors[1],
    ),

    widget.TextBox(
        **sep,
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
        distro = "Arch_checkupdates",
        update_interval = 300,
        no_update_string = "✔",
        display_format = "{updates}",
        execute = f"{term} -e paru",
        colour_have_updates = colors[0],
        colour_no_updates = colors[0],
        background = colors[2],
        foreground = colors[0],
    ),

    widget.TextBox(
        **sep,
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
        **sep,
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
        **sep,
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
        **sep,
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
        **sep,
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
        low_percentage = 0.2,
        low_foreground = colors[1],
        background = colors[8],
        foreground = colors[7],
    ),

    widget.TextBox(
        **sep,
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
        mouse_callbacks = dict(Button1 = lazy.spawn("gscal"))
    ),

    widget.TextBox(
        **sep,
        background = colors[9],
        foreground = colors[0],
    ),

    widget.Systray(),
    widget.CurrentLayoutIcon(scale = 0.75),
]

# Widgets list for secondary monitor
widgets2 = [
    widget.GroupBox(**groupbox),
    widget.TaskList(**tasklist),
    widget.TextBox(**sep, background = colors[0], foreground = colors[1]),
    widget.TextBox(**sep, background = colors[1], foreground = colors[2]),
    widget.TextBox(**sep, background = colors[2], foreground = colors[3]),
    widget.TextBox(**sep, background = colors[3], foreground = colors[4]),
    widget.TextBox(**sep, background = colors[4], foreground = colors[5]),
    widget.TextBox(**sep, background = colors[5], foreground = colors[6]),
    widget.TextBox(**sep, background = colors[6], foreground = colors[8]),
    widget.TextBox(**sep, background = colors[8], foreground = colors[9]),
    widget.Clock(format = "%A %d %B, %H:%M", background = colors[9], foreground = colors[7]),
    widget.TextBox(**sep, background = colors[9], foreground = colors[0]),
    widget.CurrentLayoutIcon(scale = 0.75),
]

# Screen settings
screens = [
    Screen(top = Bar(widgets = widgets1, background = colors[0], size = 24)),
    Screen(top = Bar(widgets = widgets2, background = colors[0], size = 24))
]

# Other settings
cursor_warp         = False
auto_minimize       = False
auto_fullscreen     = True
bring_front_click   = False
follow_mouse_focus  = True
reconfigure_screens = True

# neofetch fixes
wmname = "Qtile"
dename = ""
