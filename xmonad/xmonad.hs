-- Base
import XMonad
import System.Directory
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S

-- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory

-- Layouts
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed

-- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

-- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (mkKeymap, additionalKeysP)
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

myFont :: String
myFont = "xft:Cantarell:size=12:antialias=true:hinting=true"

myTerminal :: String
myTerminal = "alacritty"    -- Sets default terminal

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "killall xmobar"
    spawnOnce "dunst &"
    spawnOnce "picom -f &"
    spawnOnce "lxpolkit &"
    spawnOnce "nm-applet &"
    spawnOnce "flameshot &"
    spawnOnce "parcellite &"
    spawnOnce "blueman-applet &"
    spawnOncw "xss-lock -l -- i3lock-fancy &"
    spawnOnce "xwallpaper --zoom ~/.config/qtile/background.jpg"
    setWMName "Xmonad"

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall = renamed [Replace "tall"]
    $ smartBorders
    $ windowNavigation
    $ addTabs shrinkText myTabTheme
    $ subLayout [] (smartBorders Simplest)
    $ limitWindows 12
    $ mySpacing 8
    $ ResizableTall 1 (5/100) (1/2) []

spirals = renamed [Replace "spirals"]
    $ smartBorders
    $ windowNavigation
    $ addTabs shrinkText myTabTheme
    $ subLayout [] (smartBorders Simplest)
    $ mySpacing 8
    $ spiral (6/7)

floats = renamed [Replace "floats"]
    $ smartBorders
    $ limitWindows 20 simplestFloat

tabs = renamed [Replace "tabs"]
    $ tabbed shrinkText myTabTheme

-- setting colors for tabs layout and tabs sublayout.
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
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
    $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout where
        myDefaultLayout = withBorder 2 tall ||| spirals ||| noBorders tabs

myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll [
    -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
    -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8
    -- I'm doing it this way because otherwise I would have to write out the full
    -- name of my workspaces and the names would be very long if using clickable workspaces.
    isFullscreen --> doFullFloat,
    resource =? "desktop-window"    --> doIgnore,
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
    className =? "Toolkit"          --> doFloat]

-- keybindings :: [(String, X ())]
-- keybindings = [
myKeys = \c -> mkKeymap c $ [
    -- Xmonad basics
    ("M-S-r",       spawn "xmonad --restart"),          -- Restarts xmonad
    ("M-C-r",       spawn "xmonad --recompile"),        -- Recompiles xmonad
    ("M-S-q",       kill),                             -- Kill the currently focused client
    ("M-C-q",       killAll),                           -- Kill all windows on current workspace
    ("M-S-f",       withFocused $ windows . W.sink),    -- Push floating window back to tile
    ("M-C-f",       sinkAll),                           -- Push all floating windows to tile
    ("M-.",         nextScreen),                        -- Switch focus to next monitor
    ("M-,",         prevScreen),                        -- Switch focus to prev monitor
    ("M-<Tab>",     sendMessage NextLayout),            -- Switch to next layout
    -- ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts), -- Toggles noborder/full

    -- Terminal and rofi
    ("M-<Return>",  spawn myTerminal),                                      -- Spawns a terminal
    ("M-<Space>",   spawn "rofi -modi drun,run -show drun"),                -- Rofi apps menu
    ("M-S-e",       spawn "rofi -modi menu:rofi-power-menu -show menu"),    -- Rofi power menu
    ("M-S-x",       spawn "rofi -modi menu:rofi-xrandr-menu -show menu"),   -- Rofi xrandr menu
    ("M-S-d",       spawn "rofi -modi menu:rofi-dotfiles-menu -show menu"), -- Rofi dotfiles menu

    -- Useful programs to have a keybinding for launch
    ("M-f",         spawn "firefox"),
    ("M-g",         spawn "galculator"),
    ("M-t",         spawn "thunderbird"),
    ("M-s",         spawn "flameshot-gui"),
    ("M-e",         spawn $ myTerminal ++ " -t Ranger -e ranger"),

    -- Increase/decrease gaps
    ("M--",         decWindowSpacing 4),            -- Decrease window spacing
    ("M-+",         incWindowSpacing 4),            -- Increase window spacing

    -- Windows navigation
    ("M-m",         windows W.focusMaster),         -- Move focus to the master window
    ("M-j",         windows W.focusDown),           -- Move focus to the next window
    ("M-k",         windows W.focusUp),             -- Move focus to the prev window
    ("M-S-m",       windows W.swapMaster),          -- Swap the focused window and the master window
    ("M-S-j",       windows W.swapDown),            -- Swap focused window with next window
    ("M-S-k",       windows W.swapUp),              -- Swap focused window with prev window
    ("M-S-<Return>", promote),                      -- Moves focused window to master, others maintain order

    -- Increase/decrease windows in the master pane or the stack
    ("M-S-<Up>",    sendMessage (IncMasterN 1)),    -- Increase # of clients master pane
    ("M-S-<Down>",  sendMessage (IncMasterN (-1))), -- Decrease # of clients master pane
    ("M-C-<Up>",    increaseLimit),                 -- Increase # of windows
    ("M-C-<Down>",  decreaseLimit),                 -- Decrease # of windows

    -- Window resizing
    ("M-h",         sendMessage Shrink),            -- Shrink horiz window width
    ("M-l",         sendMessage Expand),            -- Expand horiz window width
    ("M-M1-j",      sendMessage MirrorShrink),      -- Shrink vert window width
    ("M-M1-k",      sendMessage MirrorExpand),      -- Expand vert window width

    -- Multimedia Keys
    ("<XF86AudioMute>",         spawn "amixer set Master toggle"),
    ("<XF86AudioLowerVolume>",  spawn "amixer set Master 5%- unmute"),
    ("<XF86AudioRaiseVolume>",  spawn "amixer set Master 5%+ unmute"),
    ("<XF86Search>",            spawn "rofi -modi drun,run -show drun"),
    ("<XF86Mail>",              runOrRaise "thunderbird" (resource =? "thunderbird")),
    ("<XF86Calculator>",        runOrRaise "galculator" (resource =? "galculator")),
    ("<Print>",                 spawn "flameshot full -p ~/Immagini/Screenshots/")] ++

      -- mod-[1..9], Switch to workspace N
      -- mod-shift-[1..9], Move client to workspace N
      -- [((m .|. modMask, k), windows $ f i)
      --     | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      --     , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
      [(m .|. modMask, k), windows $ f i)
          | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
          , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

main :: IO ()
main = do
    -- Launching three instances of xmobar on their monitors.
    xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/xmobar.hs"
    xmproc1 <- spawnPipe "xmobar -x 1 $HOME/.config/xmobar/xmobar.hs"

    -- the xmonad, ya know... what the WM is named after!
    xmonad $ ewmh def {
        manageHook = myManageHook <+> manageDocks,
        handleEventHook = docksEventHook <+> fullscreenEventHook,
        -- Uncomment this line to enable fullscreen support on things like YouTube/Netflix.
        -- This works perfect on SINGLE monitor systems. On multi-monitor systems,
        -- it adds a border around the window if screen does not have focus. So, my solution
        -- is to use a keybinding to toggle fullscreen noborders instead.  (M-<Space>)
        -- <+> fullscreenEventHook
        modMask = mod4Mask,
        keys = myKeys,
        terminal = myTerminal,
        startupHook = myStartupHook,
        layoutHook = myLayoutHook,
        workspaces = myWorkspaces,
        borderWidth = 2,
        normalBorderColor = "#242424",
        focusedBorderColor = "#1ABC9C",

        logHook = dynamicLogWithPP $ xmobarPP {                             -- XMOBAR SETTINGS --
            ppOutput = \x -> hPutStrLn xmproc0 x >> hPutStrLn xmproc1 x,    -- xmobar on both monitors
            ppCurrent = xmobarColor "#000000" "#1ABC9C",                    -- Current workspace
            ppVisible = xmobarColor "#FFFFFF" "#24574D" . clickable,        -- Visible but not current workspace
            ppHidden = xmobarColor "#1ABC9C" "" . clickable,                -- Hidden workspaces
            -- ppVisibleNoWindows = xmobarColor "#242424" "" . clickable,      -- Visible workspaces (no windows)
            ppHiddenNoWindows = xmobarColor "#242424" "" . clickable,       -- Hidden workspaces (no windows)
            ppTitle = xmobarColor "#FFFFFF" "" . shorten 60,                -- Title of active window
            ppSep =  "<fc=#666666><fn=1> | </fn></fc>",                      -- Separator character
            ppUrgent = xmobarColor "#C40000" "",                            -- Urgent workspace
            ppOrder  = \(ws:l:t) -> [ws, l] ++ t                            -- order of things in xmobar
        }
    } -- `additionalKeysP` keybindings
