-- Base
import XMonad
import System.Directory
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import Graphics.X11.ExtraTypes.XF86

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote

-- Data
import Data.Monoid
import Data.Tree
import Data.Maybe (isJust, fromJust)
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, xmobarPP, xmobarColor, shorten, wrap, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.SetWMName

-- Layouts
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed

-- Layouts modifiers
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.LayoutModifier as LM
import qualified XMonad.Layout.ToggleLayouts as T
import qualified XMonad.Layout.MultiToggle as MT
import qualified XMonad.StackSet as W

-- Utilities
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

myFont :: String
myFont = "xft:Cantarell:size=12:antialias=true:hinting=true"

myTerminal :: String
myTerminal = "alacritty"

myStartupHook :: X ()
myStartupHook = do
    spawn "killall stalonetray; stalonetray &"
    spawn "killall xmobar"
    spawnOnce "dunst &"
    spawnOnce "picom -f &"
    spawnOnce "lxpolkit &"
    spawnOnce "nm-applet &"
    spawnOnce "flameshot &"
    spawnOnce "parcellite &"
    spawnOnce "blueman-applet &"
    spawnOnce "xss-lock -l -- i3lock-fancy &"
    spawnOnce "xsetroot -cursor_name left_ptr"
    spawnOnce "xwallpaper --zoom ~/.config/qtile/background.jpg"
    setWMName "Xmonad"

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> LM.ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall = renamed [Replace "tall"]
    $ lessBorders Screen
    $ limitWindows 12
    $ mySpacing 8
    $ ResizableTall 1 (5/100) (1/2) []

tabs = renamed [Replace "tabs"]
    $ noBorders
    $ tabbed shrinkText myTabTheme

floats = renamed [Replace "floats"]
    $ limitWindows 20 simplestFloat

-- setting colors for tabs layout and tabs sublayout.
myTabTheme :: Theme
myTabTheme = def {
    fontName =              myFont,
    activeColor =           "#1ABC9C",
    inactiveColor =         "#000000",
    activeBorderColor =     "#1ABC9C",
    inactiveBorderColor =   "#000000",
    activeTextColor =       "#000000",
    inactiveTextColor =     "#D0D0D0"
}

-- The layout hook
myLayoutHook = avoidStruts
    $ mouseResize
    $ windowArrange
    $ T.toggleLayouts floats tall ||| tabs

myWorkspaces :: [String]
myWorkspaces = [
    "  \xf120  ", -- 1: Terminal
    "  \xf0ac  ", -- 2: Internet
    "  \xf0e0  ", -- 3: Email
    "  \xf07c  ", -- 4: File manager
    "  \xf086  ", -- 5: Chat
    "  \xf001  ", -- 6: Music
    "  \xf03e  ", -- 7: Picture
    "  \xf19c  ", -- 8: University
    "  \xf1b2  "] -- 9: Cube

myWorkspaceIndices :: M.Map [Char] Integer
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable :: String -> String
clickable ws = "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll [
    -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
    -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8
    -- I'm doing it this way because otherwise I would have to write out the full
    -- name of my workspaces and the names would be very long if using clickable workspaces.
    isFullscreen                    --> doFullFloat,
    className =? "confirm"          --> doFloat,
    className =? "confirmreset"     --> doFloat,
    className =? "dialog"           --> doFloat,
    className =? "download"         --> doFloat,
    className =? "error"            --> doFloat,
    className =? "file_progress"    --> doFloat,
    className =? "lxpolkit"         --> doFloat,
    className =? "notification"     --> doFloat,
    className =? "pinentry-gtk-2"   --> doFloat,
    className =? "splash"           --> doFloat,
    className =? "toolbar"          --> doFloat,
    className =? "Toolkit"          --> doFloat,
    className =? "stalonetray"      --> doIgnore]

myKeys :: XConfig l -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $ [
    -- Xmonad basics
    ((modMask .|. shiftMask,    xK_r),      spawn "xmonad --restart"),          -- Restarts xmonad
    ((modMask .|. controlMask,  xK_r),      spawn "xmonad --recompile"),        -- Recompiles xmonad
    ((modMask .|. shiftMask,    xK_q),      kill),                              -- Kill the currently focused client
    ((modMask .|. controlMask,  xK_q),      killAll),                           -- Kill all windows on current workspace
    ((modMask .|. shiftMask,    xK_f),      withFocused $ windows . W.sink),    -- Push floating window back to tile
    ((modMask .|. controlMask,  xK_f),      sinkAll),                           -- Push all floating windows to tile
    ((modMask,                  xK_period), nextScreen),                        -- Switch focus to next monitor
    ((modMask,                  xK_comma),  prevScreen),                        -- Switch focus to prev monitor
    ((modMask,                  xK_Tab),    sendMessage NextLayout),            -- Switch to next layout
    ((modMask .|. shiftMask,    xK_space),                                      -- Toggles noborder/full
        sendMessage (MT.Toggle NBFULL) >>
        sendMessage ToggleStruts),

    -- Terminal and rofi
    ((modMask,                  xK_Return), spawn myTerminal),                                  -- Spawns a terminal
    ((modMask,                  xK_space),  spawn "rofi -modi drun,run -show drun"),                -- Rofi apps menu
    ((modMask .|. shiftMask,    xK_e),      spawn "rofi -modi menu:rofi-power-menu -show menu"),    -- Rofi power menu
    ((modMask .|. shiftMask,    xK_x),      spawn "rofi -modi menu:rofi-xrandr-menu -show menu"),   -- Rofi xrandr menu
    ((modMask .|. shiftMask,    xK_d),      spawn "rofi -modi menu:rofi-dotfiles-menu -show menu"), -- Rofi dotfiles menu

    -- Useful programs to have a keybinding for launch
    ((modMask,                  xK_f),      spawn "firefox"),
    ((modMask,                  xK_g),      spawn "galculator"),
    ((modMask,                  xK_t),      spawn "thunderbird"),
    ((modMask,                  xK_s),      spawn "flameshot-gui"),
    ((modMask,                  xK_e),      spawn $ myTerminal ++ " -t Ranger -e ranger"),

    -- Increase/decrease gaps
    ((modMask,                  xK_minus),  decWindowSpacing 4),           -- Decrease window spacing
    ((modMask,                  xK_plus),   incWindowSpacing 4),           -- Increase window spacing

    -- Windows navigation
    ((modMask,                  xK_m),      windows W.focusMaster),        -- Move focus to the master window
    ((modMask,                  xK_j),      windows W.focusDown),          -- Move focus to the next window
    ((modMask,                  xK_k),      windows W.focusUp),            -- Move focus to the prev window
    ((modMask .|. shiftMask,    xK_m),      windows W.swapMaster),         -- Swap the focused window and the master window
    ((modMask .|. shiftMask,    xK_j),      windows W.swapDown),           -- Swap focused window with next window
    ((modMask .|. shiftMask,    xK_k),      windows W.swapUp),             -- Swap focused window with prev window
    ((modMask .|. shiftMask,    xK_Return), promote),                      -- Moves focused window to master, others maintain order

    -- Increase/decrease windows in the master pane or the stack
    ((modMask .|. shiftMask,    xK_Up),    sendMessage (IncMasterN 1)),    -- Increase # of clients master pane
    ((modMask .|. shiftMask,    xK_Down),  sendMessage (IncMasterN (-1))), -- Decrease # of clients master pane
    ((modMask .|. controlMask,  xK_Up),    increaseLimit),                 -- Increase # of windows
    ((modMask .|. controlMask,  xK_Down),  decreaseLimit),                 -- Decrease # of windows

    -- Window resizing
    ((modMask,                  xK_h),      sendMessage Shrink),            -- Shrink horiz window width
    ((modMask,                  xK_l),      sendMessage Expand),            -- Expand horiz window width
    ((modMask .|. controlMask,  xK_j),      sendMessage MirrorShrink),      -- Shrink vert window width
    ((modMask .|. controlMask,  xK_k),      sendMessage MirrorExpand),      -- Expand vert window width

    -- Multimedia Keys
    ((0, xF86XK_MonBrightnessUp),           spawn "brightlight -i 239"),
    ((0, xF86XK_MonBrightnessDown),         spawn "brightlight -d 239"),
    ((0, xF86XK_AudioLowerVolume),          spawn "amixer set Master 5%- unmute"),
    ((0, xF86XK_AudioRaiseVolume),          spawn "amixer set Master 5%+ unmute"),
    ((0, xF86XK_AudioMute),                 spawn "amixer set Master toggle"),
    ((0, xF86XK_Search),                    spawn "rofi -modi drun,run -show drun")] ++

    -- mod+[1..9]: Switch to workspace X
    -- mod+ctrl+[1..9]: Move client to workspace X
    -- mod+shift+[1..9]: Move client to workspace X and focus workspace X
    [((modMask .|. m, k), windows $ f i) |
        (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
        (f, m) <- [(W.greedyView, 0), (W.shift, controlMask),
        (\i -> W.greedyView i . W.shift i, shiftMask)]]

main :: IO ()
main = do
    -- Launching three instances of xmobar on their monitors.
    xmproc0 <- spawnPipe "xmobar -x 0 ~/.config/xmobar/xmobar.hs"
    xmproc1 <- spawnPipe "xmobar -x 1 ~/.config/xmobar/xmobar.hs"

    xmonad $ ewmh def {
        manageHook = myManageHook <+> manageDocks <+> doF W.swapDown,
        handleEventHook = docksEventHook {- <+> fullscreenEventHook -},
        modMask = mod4Mask,
        keys = myKeys,
        terminal = myTerminal,
        startupHook = myStartupHook,
        layoutHook = myLayoutHook,
        workspaces = myWorkspaces,
        borderWidth = 2,
        normalBorderColor = "#242424",
        focusedBorderColor = "#1ABC9C",
        logHook = dynamicLogWithPP $ xmobarPP {                                                         -- XMOBAR SETTINGS --
            ppOutput =          \x -> hPutStrLn xmproc0 x >> hPutStrLn xmproc1 x,                       -- xmobar on both monitors
            ppCurrent =         xmobarColor "#FFFFFF" "#24574D" . wrap "<fn=1>" "</fn>",                -- Current workspace
            ppVisible =         xmobarColor "#1ABC9C" ""        . wrap "<fn=1>" "</fn>" . clickable,    -- Visible but not current workspace
            ppHidden =          xmobarColor "#FFFFFF" ""        . wrap "<fn=1>" "</fn>" . clickable,    -- Hidden workspaces
            ppHiddenNoWindows = xmobarColor "#242424" ""        . wrap "<fn=1>" "</fn>" . clickable,    -- Hidden workspaces (no windows)
            ppUrgent =          xmobarColor "#C40000" ""        . wrap "<fn=1>" "</fn>" . clickable,    -- Urgent workspace
            ppTitle =           shorten 40,                                                             -- Title of active window
            ppSep =             "<fc=#666666>  |  </fc>",                                               -- Separator between modules
            ppWsSep =           "",                                                                     -- Separator between WS tags
            ppOrder =           \(ws:l:t) -> [ws, l] ++ t                                               -- order of things in xmobar
        }
    }
