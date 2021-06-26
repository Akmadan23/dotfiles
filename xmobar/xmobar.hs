Config {
    font = "xft:Cantarell:weight=Bold:pixelsize=16",
    additionalFonts = ["xft:FontAwesome:pixelsize=16"],
    bgColor = "#000000",
    fgColor = "#E0E0E0",
    position = Top,
    lowerOnStart = True,
    pickBroadest = False,
    persistent = False,
    hideOnStart = False,
    overrideRedirect = True,
    sepChar = "%",
    alignSep = "}{",
    template = "%UnsafeStdinReader% } %date% { %cpu%",
    commands = [
        Run Cpu ["-L","3","-H","50", "--normal","white","--high","red"] 20,
        Run Date "%A %d %B, %H:%M" "date" 20,
        Run UnsafeStdinReader
    ]
}
