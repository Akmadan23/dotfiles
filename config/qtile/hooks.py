import subprocess as sp
from libqtile import hook

# Monitor detection script
@hook.subscribe.startup_once
def autostart_once():
    cmd_dp = sp.run("xrandr | grep -q 'DP2-1 connected'", shell = True)
    cmd_hdmi = sp.run("xrandr | grep -q 'HDMI1 connected'", shell = True)

    if cmd_dp.returncode == 0:
        external_name = "DP2-1"
    elif cmd_hdmi.returncode == 0:
        external_name = "HDMI1"
    else:
        sp.run(f"""xrandr
            --output eDP1 --mode 1600x900
            --output HDMI1 --off
            --output DP2-1 --off""".split())

        return

    sp.run(f"""xrandr
        --output eDP1               --mode 1600x900  --pos 0x180
        --output {external_name}    --mode 1920x1080 --pos 1600x0 --primary""".split())

# Autostart script
@hook.subscribe.startup
def autostart():
    apps = [
        ["conky",           ""],        # desktop widgets
        ["dunst",           ""],        # notification daemon
        ["picom",           " -bf"],    # compositor
        ["lxpolkit",        ""],        # authentication agent
        ["clipmenud",       ""],        # clipboard manager
        ["nm-applet",       ""],        # network manager
        ["eject-applet",    ""],        # external disk manager
        ["blueman-applet",  ""],        # bluetooth manager
        ["light-locker",    ""],        # lock screen using lightdm
        ["battery-check",   ""],        # handmade power management script
        ["pasystray",       " --include-monitors --notify=none"],
        ["xwallpaper",      " --zoom ~/.config/qtile/background.jpg"],
    ]

    for a in apps:
        sp.run(f"pgrep -x {a[0]} || {a[0] + a[1]} &", shell = True)
