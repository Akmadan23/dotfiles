# pyright: reportPrivateImportUsage = false
import os, hooks as _
from libqtile import layout, widget
from libqtile.lazy import lazy
from libqtile.config import Bar, Click, Drag, Group, Key, KeyChord, Match, Screen

# Keys aliases constants
MOD = ["mod4"]
S_MOD = ["mod4", "shift"]
C_MOD = ["mod4", "control"]
A_MOD = ["mod4", "mod1"]
CA_MOD = ["mod4", "mod1", "control"]
SCA_MOD = ["mod4", "mod1", "control", "shift"]

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

# A quick way to set background and foreground colors in widgets
def bg_fg(bg: int, fg: int):
    return dict(background = colors[bg], foreground = colors[fg])

def rofi(s: str):
    return f"rofi -modi x:~/.config/rofi/scripts/rofi-{s} -show"

def xdt_mouse(x: int, y: int):
    return f"xdotool mousemove_relative -- {x} {y}"

def xdt_click(n: int):
    return f"xdotool click {n}"

# Keyboard bindings
keys = [
    # Switch between windows
    Key(MOD,    "h",        lazy.layout.left()),
    Key(MOD,    "j",        lazy.layout.down()),
    Key(MOD,    "k",        lazy.layout.up()),
    Key(MOD,    "l",        lazy.layout.right()),

    # Move windows in current stack
    Key(S_MOD,  "h",        lazy.layout.shuffle_left()),
    Key(S_MOD,  "j",        lazy.layout.shuffle_down()),
    Key(S_MOD,  "k",        lazy.layout.shuffle_up()),
    Key(S_MOD,  "l",        lazy.layout.shuffle_right()),

    # Grow windows
    Key(C_MOD,  "h",        lazy.layout.grow_left()),
    Key(C_MOD,  "j",        lazy.layout.grow_down()),
    Key(C_MOD,  "k",        lazy.layout.grow_up()),
    Key(C_MOD,  "l",        lazy.layout.grow_right()),

    # Windows and layout behaviour
    Key(S_MOD,  "r",        lazy.restart()),
    Key(S_MOD,  "q",        lazy.window.kill()),
    Key(S_MOD,  "m",        lazy.window.toggle_minimize()),
    Key(S_MOD,  "f",        lazy.window.toggle_floating()),
    Key(S_MOD,  "s",        lazy.layout.toggle_split()),
    Key(S_MOD,  "n",        lazy.layout.normalize()),

    # Switch between monitors
    Key(MOD,    "comma",    lazy.prev_screen()),
    Key(MOD,    "period",   lazy.next_screen()),

    # Toggle between different layouts
    Key(MOD,    "Tab",      lazy.next_layout()),
    Key(S_MOD,  "Tab",      lazy.prev_layout()),

    # Terminal and rofi
    Key(MOD,    "Return",   lazy.spawn(term)),
    Key(MOD,    "space",    lazy.spawn("rofi -modi drun,run -show drun")),
    Key(S_MOD,  "space",    lazy.spawn("rofi -modi emoji -show emoji")),
    Key(S_MOD,  "e",        lazy.spawn(rofi("power-menu"))),
    Key(S_MOD,  "x",        lazy.spawn(rofi("xrandr-menu"))),
    Key(S_MOD,  "d",        lazy.spawn(rofi("dotfiles-menu"))),

    # App spawning
    Key(MOD,    "f",        lazy.spawn("firefox")),
    Key(MOD,    "x",        lazy.spawn("firefox -P extra")),
    Key(MOD,    "c",        lazy.spawn("qalculate-gtk")),
    Key(MOD,    "s",        lazy.spawn("flameshot gui")),
    Key(S_MOD,  "v",        lazy.spawn("clipmenu")),
    Key(MOD,    "e",        lazy.spawn(f"{term} -t Joshuto -e josh")),

    # Volume and brightness controls
    Key(MOD,    "Up",       lazy.spawn("vol +5")),                      # +5% volume
    Key(MOD,    "Down",     lazy.spawn("vol -5")),                      # -5% volume
    Key(MOD,    "m",        lazy.spawn("vol mute")),                    # mute
    Key(MOD,    "Right",    lazy.spawn("xbacklight -inc 5 -steps 1")),  # +5% backlight
    Key(MOD,    "Left",     lazy.spawn("xbacklight -dec 5 -steps 1")),  # -5% backlight
    Key(MOD,    "r",        lazy.spawn("xbacklight -set 50")),          # backlight = 50%

    # Move mouse with keyboard
    Key(A_MOD,  "h",        lazy.spawn(xdt_mouse(-64, 0))), # move pointer 64px left
    Key(A_MOD,  "j",        lazy.spawn(xdt_mouse(0, 64))),  # move pointer 64px down
    Key(A_MOD,  "k",        lazy.spawn(xdt_mouse(0, -64))), # move pointer 64px up
    Key(A_MOD,  "l",        lazy.spawn(xdt_mouse(64, 0))),  # move pointer 64px right
    Key(CA_MOD, "h",        lazy.spawn(xdt_mouse(-4, 0))),  # move pointer 4px left
    Key(CA_MOD, "j",        lazy.spawn(xdt_mouse(0, 4))),   # move pointer 4px down
    Key(CA_MOD, "k",        lazy.spawn(xdt_mouse(0, -4))),  # move pointer 4px up
    Key(CA_MOD, "l",        lazy.spawn(xdt_mouse(4, 0))),   # move pointer 4px right
    Key(A_MOD,  "space",    lazy.spawn(xdt_click(1))),      # left click
    Key(CA_MOD, "space",    lazy.spawn(xdt_click(2))),      # center click
    Key(SCA_MOD,"space",    lazy.spawn(xdt_click(3))),      # right click

    # Special keys
    Key([], "XF86MonBrightnessUp",      lazy.spawn("xbacklight -inc 5 -steps 1")),      # +5% backlight
    Key([], "XF86MonBrightnessDown",    lazy.spawn("xbacklight -dec 5 -steps 1")),      # -5% backlight
    Key([], "XF86AudioRaiseVolume",     lazy.spawn("vol +5")),    # +5% volume
    Key([], "XF86AudioLowerVolume",     lazy.spawn("vol -5")),    # -5% volume
    Key([], "XF86AudioMute",            lazy.spawn("vol mute")),        # mute

    # Set volume
    KeyChord(MOD, "v", [Key([], str(i), lazy.spawn(f"amixer set Master {i}0%")) for i in range(1, 10)]),

    # Set brightness
    KeyChord(MOD, "b", [Key([], str(i), lazy.spawn(f"xbacklight -set {i}0")) for i in range(1, 10)]),
]

#                1    2    3    4    5    6    7    8    9
labels = [None, "", "", "", "", "", "", "", "", ""]
groups = [Group(name = str(i), label = labels[i]) for i in range(1, 10)]

for g in groups:
    keys.extend([
        Key(MOD,    g.name, lazy.group[g.name].toscreen()),
        Key(S_MOD,  g.name, lazy.window.togroup(g.name, switch_group = True)),
        Key(C_MOD,  g.name, lazy.window.togroup(g.name, switch_group = False)),
    ])

# Mouse bindings
mouse = [
    Drag(MOD,       "Button1", lazy.window.set_position_floating(), start = lazy.window.get_position()),
    Drag(MOD,       "Button3", lazy.window.set_size_floating(),     start = lazy.window.get_size()),
    # Click(MOD,      "Button4", lazy.spawn("vol +5")),
    # Click(MOD,      "Button5", lazy.spawn("vol -5")),
]

# Layouts list
layouts = [
    layout.Columns(
        border_normal = colors[0],
        border_normal_stack = colors[0],
        border_focus = colors[4],
        border_focus_stack = colors[2],
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
    markup_floating = "<i>{}</i>",
    markup_focused = "<b>{}</b>",
    markup_focused_floating = "<b><i>{}</i></b>",
)

# Widgets list for primary monitor
widgets1 = [
    widget.GroupBox(**groupbox),
    widget.TaskList(**tasklist),
    widget.TextBox(**sep, **bg_fg(0, 1)),
    widget.TextBox(**sep, **bg_fg(1, 2)),

    widget.TextBox(
        text = "",
        font = awesome,
        fontsize = 12,
        **bg_fg(2, 0),
    ),

    widget.CheckUpdates(
        distro = "Arch_checkupdates",
        update_interval = 300,
        no_update_string = "✔",
        display_format = "{updates}",
        execute = f"{term} -e paru",
        colour_have_updates = colors[0],
        colour_no_updates = colors[0],
        **bg_fg(2, 0),
    ),

    widget.TextBox(**sep, **bg_fg(2, 3)),

    widget.TextBox(
        text = "",
        font = awesome,
        **bg_fg(3, 0),
    ),

    widget.Memory(
        format = "{MemUsed: .2f}/{MemTotal: .0f} GB",
        measure_mem = "G",
        update_interval = 2,
        **bg_fg(3, 0),
    ),

    widget.TextBox(**sep, **bg_fg(3, 4)),

    widget.TextBox(
        text = "",
        font = awesome,
        **bg_fg(4, 0),
    ),

    widget.ThermalSensor(
        update_interval = 2,
        foreground_alert = "#FF0000",
        threshold = 90,
        **bg_fg(4, 0),
    ),

    widget.TextBox(**sep, **bg_fg(4, 5)),

    widget.TextBox(
        text = "",
        font = awesome,
        **bg_fg(5, 0),
    ),

    widget.Backlight(
        backlight_name = "intel_backlight",
        brightness_file = "brightness",
        change_command = None,
        **bg_fg(5, 0),
    ),

    widget.TextBox(**sep, **bg_fg(5, 6)),

    widget.TextBox(
        text = "",
        font = awesome,
        **bg_fg(6, 0),
    ),

    widget.Volume(
        step = 5,
        **bg_fg(6, 0),
    ),

    widget.TextBox(**sep, **bg_fg(6, 8)),

    widget.TextBox(
        text = "",
        font = awesome,
        fontsize = 16,
        **bg_fg(8, 7),
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
        low_foreground = "#FF0000",
        **bg_fg(8, 7),
    ),

    widget.TextBox(**sep, **bg_fg(8, 9)),

    widget.TextBox(
        text = "",
        font = awesome,
        fontsize = 12,
        **bg_fg(9, 7),
    ),

    widget.Clock(
        format = "%A %d %B, %H:%M",
        mouse_callbacks = dict(Button1 = lazy.spawn("gscal")),
        **bg_fg(9, 7),
    ),

    widget.TextBox(**sep, **bg_fg(9, 0)),
    widget.Systray(),
    # widget.CapsNumLockIndicator(),
    widget.CurrentLayoutIcon(scale = 0.75),
]

# Widgets list for secondary monitor
widgets2 = [
    widget.GroupBox(**groupbox),
    widget.TaskList(**tasklist),
    widget.TextBox(**sep, **bg_fg(0, 1)),
    widget.TextBox(**sep, **bg_fg(1, 2)),
    widget.TextBox(**sep, **bg_fg(2, 3)),
    widget.TextBox(**sep, **bg_fg(3, 4)),
    widget.TextBox(**sep, **bg_fg(4, 5)),
    widget.TextBox(**sep, **bg_fg(5, 6)),
    widget.TextBox(**sep, **bg_fg(6, 8)),
    widget.TextBox(**sep, **bg_fg(8, 9)),
    widget.Clock(format = "%A %d %B, %H:%M", **bg_fg(9, 7)),
    widget.TextBox(**sep, **bg_fg(9, 0)),
    widget.CurrentLayoutIcon(scale = 0.75),
]

screen_defaults = dict(backgroud = colors[0], size = 24)

# Screen settings
screens = [
    Screen(top = Bar(widgets = widgets1, **screen_defaults)),
    Screen(top = Bar(widgets = widgets2, **screen_defaults))
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
