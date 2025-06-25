import subprocess as sp
from libqtile import hook

# Monitor detection script
@hook.subscribe.startup_once
def autostart_once():
    xrandr = sp.run("xrandr", capture_output = True).stdout.decode()
    ext_name = None

    if "DP2-1 connected" in xrandr:
        ext_name = "DP2-1"
    elif "HDMI1 connected" in xrandr:
        ext_name = "HDMI1"

    if ext_name:
        cmd = f"""xrandr
            --output eDP1       --mode 1600x900  --pos 0x180
            --output {ext_name} --mode 1920x1080 --pos 1600x0 --primary"""
    else:
        cmd = """xrandr
            --output eDP1   --mode 1600x900
            --output HDMI1  --off
            --output DP2-1  --off"""

    sp.run(cmd.split())

# Autostart script
@hook.subscribe.startup
def autostart():
    cmd = ""
    programs = {
        "picom": " -bf",
        "dunst": "",
        "lxpolkit": "",
        "clipmenud": "",
        "nm-applet": "",
        "eject-applet": "",
        "blueman-applet": "",
        "light-locker": "",
        "battery-check": "",
        "volnoti": "",
        "pasystray": " --include-monitors --notify=none",
        "xwallpaper": " --zoom ~/.config/qtile/background.jpg",
    }

    for app, args in programs.items():
        cmd += f"pgrep -x {app} || {app + args} &\n"

    sp.run(cmd, shell = True)
