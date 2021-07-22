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
    template = "%UnsafeStdinReader% } <action='gsimplecal'>%date%</action> { %default:Master% <fc=#666666>|</fc> %battery% <fc=#666666>|</fc> %cpu%",
    commands = [
        Run Volume "default" "Master" [] 10,
        Run Date "%A %d %B, %H:%M" "date" 20,
        Run Cpu ["-L","3","-H","50", "--normal","white","--high","red"] 20,
        -- Run Com "/home/azadahmadi/.config/xmobar/scripts/update" [] "updates" 36000,
        Run Com "/home/azadahmadi/.config/xmobar/scripts/battery" [] "battery" 600,
        Run UnsafeStdinReader
    ]
}
