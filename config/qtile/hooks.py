import subprocess as sp
from os import path
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
    cmd = ""

    with open(path.expanduser("~/git-repos/dotfiles/autostart.csv")) as f:
        for app, args in [l.strip().split(";") for l in f.readlines()]:
            cmd += f"pgrep -x {app} || {app + args} &\n"

    sp.run(cmd, shell = True)
