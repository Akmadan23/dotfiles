# pyright: reportPrivateImportUsage = false
import hooks as _, utils as u
from libqtile import layout, widget
from libqtile.lazy import lazy
from libqtile.config import Bar, Drag, Group, Key, KeyChord, Match, Screen

# Keyboard bindings
keys = [
    # Switch between windows
    Key([u.mod],            "h",        lazy.layout.left()),
    Key([u.mod],            "j",        lazy.layout.down()),
    Key([u.mod],            "k",        lazy.layout.up()),
    Key([u.mod],            "l",        lazy.layout.right()),

    # Move windows in current stack
    Key([u.mod, u.sft],     "h",        lazy.layout.shuffle_left()),
    Key([u.mod, u.sft],     "j",        lazy.layout.shuffle_down()),
    Key([u.mod, u.sft],     "k",        lazy.layout.shuffle_up()),
    Key([u.mod, u.sft],     "l",        lazy.layout.shuffle_right()),

    # Switch between monitors
    Key([u.mod],            "comma",    lazy.prev_screen()),
    Key([u.mod],            "period",   lazy.next_screen()),

    # Windows and layout behaviour
    Key([u.mod, u.sft],     "r",        lazy.restart()),
    Key([u.mod, u.sft],     "q",        lazy.window.kill()),
    Key([u.mod, u.sft],     "n",        lazy.layout.normalize()),
    Key([u.mod, u.sft],     "f",        lazy.window.toggle_floating()),
    Key([u.mod],            "plus",     lazy.layout.grow()),
    Key([u.mod],            "minus",    lazy.layout.shrink()),

    # Toggle between different layouts
    Key([u.mod],            "Tab",      lazy.next_layout()),
    Key([u.mod, u.sft],     "Tab",      lazy.prev_layout()),

    # Terminal and rofi
    Key([u.mod],            "Return",   lazy.spawn(u.term)),
    Key([u.mod],            "space",    lazy.spawn("rofi -modi drun,run -show drun")),
    Key([u.mod, u.sft],     "e",        lazy.spawn("rofi -modi x:~/.config/rofi/scripts/rofi-power-menu -show")),
    Key([u.mod, u.sft],     "x",        lazy.spawn("rofi -modi x:~/.config/rofi/scripts/rofi-xrandr-menu -show")),
    Key([u.mod, u.sft],     "d",        lazy.spawn("rofi -modi x:~/.config/rofi/scripts/rofi-dotfiles-menu -show")),

    # App spawning
    Key([u.mod],            "f",        lazy.spawn("firefox")),
    Key([u.mod],            "x",        lazy.spawn("firefox -P extra")),
    Key([u.mod],            "c",        lazy.spawn("qalculate-gtk")),
    Key([u.mod],            "s",        lazy.spawn("flameshot gui")),
    Key([u.mod, u.sft],     "v",        lazy.spawn("clipmenu")),
    Key([u.mod],            "e",        lazy.spawn(f"{u.term} -t Ranger -e ranger")),

    # Volume and brightness controls
    Key([u.mod],            "Up",       lazy.spawn("amixer set Master unmute 5%+")),        # +5% volume
    Key([u.mod],            "Down",     lazy.spawn("amixer set Master unmute 5%-")),        # -5% volume
    Key([u.mod],            "m",        lazy.spawn("amixer set Master toggle")),            # mute
    Key([u.mod],            "Right",    lazy.spawn("xbacklight -inc 5 -steps 1")),          # +5% backlight
    Key([u.mod],            "Left",     lazy.spawn("xbacklight -dec 5 -steps 1")),          # -5% backlight
    Key([u.mod],            "r",        lazy.spawn("xbacklight -set 50")),                  # sets backlight to 50%

    # Move with keyboard
    Key([u.alt, u.ctrl],    "h",        lazy.spawn("xdotool mousemove_relative -- -4 0")),  # move pointer 4px left
    Key([u.alt, u.ctrl],    "j",        lazy.spawn("xdotool mousemove_relative -- 0 4")),   # move pointer 4px down
    Key([u.alt, u.ctrl],    "k",        lazy.spawn("xdotool mousemove_relative -- 0 -4")),  # move pointer 4px up
    Key([u.alt, u.ctrl],    "l",        lazy.spawn("xdotool mousemove_relative -- 4 0")),   # move pointer 4px right
    Key([u.alt],            "h",        lazy.spawn("xdotool mousemove_relative -- -64 0")), # move pointer 64px left
    Key([u.alt],            "j",        lazy.spawn("xdotool mousemove_relative -- 0 64")),  # move pointer 64px down
    Key([u.alt],            "k",        lazy.spawn("xdotool mousemove_relative -- 0 -64")), # move pointer 64px up
    Key([u.alt],            "l",        lazy.spawn("xdotool mousemove_relative -- 64 0")),  # move pointer 64px right
    Key([u.alt],            "b",        lazy.spawn("xdotool click 1")),                     # left click
    Key([u.alt],            "n",        lazy.spawn("xdotool click 2")),                     # center click
    Key([u.alt],            "m",        lazy.spawn("xdotool click 3")),                     # right click

    # Special keys
    Key([], "XF86MonBrightnessUp",      lazy.spawn("xbacklight -inc 5 -steps 1")),          # +5% backlight
    Key([], "XF86MonBrightnessDown",    lazy.spawn("xbacklight -dec 5 -steps 1")),          # -5% backlight
    Key([], "XF86AudioRaiseVolume",     lazy.spawn("amixer set Master unmute 5%+")),        # +5% volume
    Key([], "XF86AudioLowerVolume",     lazy.spawn("amixer set Master unmute 5%-")),        # -5% volume
    Key([], "XF86AudioMute",            lazy.spawn("amixer set Master toggle")),            # mute

    # Set volume
    KeyChord([u.mod], "v", [Key([], str(i), lazy.spawn(f"amixer set Master {str(i)}0%")) for i in range(1, 10)]),

    # Set brightness
    KeyChord([u.mod], "b", [Key([], str(i), lazy.spawn(f"xbacklight -set {str(i)}0")) for i in range(1, 10)]),
]

# Mouse bindings
mouse = [
    Drag([u.mod], "Button1", lazy.window.set_position_floating(), start = lazy.window.get_position()),
    Drag([u.mod], "Button3", lazy.window.set_size_floating(),     start = lazy.window.get_size()),
]

#                1    2    3    4    5    6    7    8    9
labels = [None, "", "", "", "", "", "", "", "", ""]
groups = [Group(name = str(i), label = labels[i]) for i in range(1, 10)]

for i in groups:
    keys.extend([
        Key([u.mod],            i.name, lazy.group[i.name].toscreen()),
        Key([u.mod, u.sft],     i.name, lazy.window.togroup(i.name, switch_group = True)),
        Key([u.mod, u.ctrl],    i.name, lazy.window.togroup(i.name, switch_group = False)),
    ])

# Default layout theme
layout_theme = dict(
    border_normal = u.colors[0],
    border_focus = u.colors[4],
    border_width = 2,
    single_border_width = 0,
    margin = 8,
    single_margin = 0,
)

# Layouts list
layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme, ratio = 0.6),
    layout.Max(),
]

floating_layout = layout.Floating(
    border_focus = u.colors[3],
    border_normal = u.colors[0],
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
    fontsize = 24,
    padding = 0,
    margin = 0
)

# GroupBox defaults
groupbox = dict(
    font = u.awesome,
    active = u.colors[7],
    inactive = u.colors[8],
    urgent_border = u.colors[5],
    this_screen_border = u.colors[4],
    this_current_screen_border = u.colors[4],
    other_screen_border = u.colors[8],
    other_current_screen_border = u.colors[8],
    highlight_color = [u.colors[0], u.colors[4]],
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
        background = u.colors[0],
        foreground = u.colors[1],
    ),

    widget.TextBox(
        **sep,
        background = u.colors[1],
        foreground = u.colors[2],
    ),

    widget.TextBox(
        text = "",
        font = u.awesome,
        fontsize = 12,
        background = u.colors[2],
        foreground = u.colors[0],
    ),

    widget.CheckUpdates(
        distro = "Arch_checkupdates",
        update_interval = 300,
        no_update_string = "✔",
        display_format = "{updates}",
        execute = f"{u.term} -e paru",
        colour_have_updates = u.colors[0],
        colour_no_updates = u.colors[0],
        background = u.colors[2],
        foreground = u.colors[0],
    ),

    widget.TextBox(
        **sep,
        background = u.colors[2],
        foreground = u.colors[3],
    ),

    widget.TextBox(
        text = "",
        font = u.awesome,
        background = u.colors[3],
        foreground = u.colors[0],
    ),

    widget.Memory(
        format = "{MemUsed: .2f}/{MemTotal: .0f} GB",
        measure_mem = "G",
        update_interval = 2,
        background = u.colors[3],
        foreground = u.colors[0],
    ),

    widget.TextBox(
        **sep,
        background = u.colors[3],
        foreground = u.colors[4],
    ),

    widget.TextBox(
        text = "",
        font = u.awesome,
        background = u.colors[4],
        foreground = u.colors[0],
    ),

    widget.ThermalSensor(
        update_interval = 2,
        foreground_alert = u.colors[1],
        threshold = 90,
        background = u.colors[4],
        foreground = u.colors[0],
    ),

    widget.TextBox(
        **sep,
        background = u.colors[4],
        foreground = u.colors[5],
    ),

    widget.TextBox(
        text = "",
        font = u.awesome,
        background = u.colors[5],
        foreground = u.colors[0],
    ),

    widget.Backlight(
        backlight_name = "intel_backlight",
        brightness_file = "brightness",
        change_command = None,
        background = u.colors[5],
        foreground = u.colors[0],
    ),

    widget.TextBox(
        **sep,
        background = u.colors[5],
        foreground = u.colors[6],
    ),

    widget.TextBox(
        text = "",
        font = u.awesome,
        background = u.colors[6],
        foreground = u.colors[0],
    ),

    widget.Volume(
        step = 5,
        background = u.colors[6],
        foreground = u.colors[0],
    ),

    widget.TextBox(
        **sep,
        background = u.colors[6],
        foreground = u.colors[8],
    ),

    widget.TextBox(
        text = "",
        font = u.awesome,
        fontsize = 16,
        background = u.colors[8],
        foreground = u.colors[7],
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
        low_foreground = u.colors[1],
        background = u.colors[8],
        foreground = u.colors[7],
    ),

    widget.TextBox(
        **sep,
        background = u.colors[8],
        foreground = u.colors[9],
    ),

    widget.TextBox(
        text = "",
        font = u.awesome,
        fontsize = 12,
        background = u.colors[9],
        foreground = u.colors[7],
    ),

    widget.Clock(
        format = "%A %d %B, %H:%M",
        background = u.colors[9],
        foreground = u.colors[7],
        mouse_callbacks = dict(Button1 = lazy.spawn("gscal"))
    ),

    widget.TextBox(
        **sep,
        background = u.colors[9],
        foreground = u.colors[0],
    ),

    widget.Systray(),
    widget.CurrentLayoutIcon(scale = 0.75),
]

# Widgets list for secondary monitor
widgets2 = [
    widget.GroupBox(**groupbox),
    widget.TaskList(**tasklist),
    widget.TextBox(**sep, background = u.colors[0], foreground = u.colors[1]),
    widget.TextBox(**sep, background = u.colors[1], foreground = u.colors[2]),
    widget.TextBox(**sep, background = u.colors[2], foreground = u.colors[3]),
    widget.TextBox(**sep, background = u.colors[3], foreground = u.colors[4]),
    widget.TextBox(**sep, background = u.colors[4], foreground = u.colors[5]),
    widget.TextBox(**sep, background = u.colors[5], foreground = u.colors[6]),
    widget.TextBox(**sep, background = u.colors[6], foreground = u.colors[8]),
    widget.TextBox(**sep, background = u.colors[8], foreground = u.colors[9]),
    widget.Clock(format = "%A %d %B, %H:%M", background = u.colors[9], foreground = u.colors[7]),
    widget.TextBox(**sep, background = u.colors[9], foreground = u.colors[0]),
    widget.CurrentLayoutIcon(scale = 0.75),
]

# Screen settings
screens = [
    Screen(top = Bar(widgets = widgets1, background = u.colors[0], size = 24)),
    Screen(top = Bar(widgets = widgets2, background = u.colors[0], size = 24))
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
