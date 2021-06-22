Config {
    font = "xft:Cantarell:weight=Regular:pixelsize=16",
    additionalFonts = [
        "xft:Hasklug Nerd Font:pixelsize=12",
        "xft:FontAwesome:pixelsize=16"
    ],
    border = TopB,
    borderColor = "#000000",
    bgColor = "#000000",
    fgColor = "#E0E0E0",
    position = Top,
    lowerOnStart = True,
    pickBroadest = False,
    persistent = False,
    hideOnStart = False,
    iconRoot = ".",
    allDesktops = True,
    overrideRedirect = True,
    commands = [
        Run Network "eth1" ["-L","0","-H","32", "--normal","green","--high","red"] 10,
        Run Cpu ["-L","3","-H","50", "--normal","green","--high","red"] 10,
        Run Memory ["-t","Mem: <usedratio>%"] 10,
        Run Date "%A %d %B, %H:%M" "date" 10,
        Run UnsafeStdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%UnsafeStdinReader% }{ %cpu% <fc=#000000,#1ABC9C>%date%</fc>"
}
