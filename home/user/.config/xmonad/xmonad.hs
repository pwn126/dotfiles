{-# LANGUAGE FlexibleContexts, NoMonomorphismRestriction #-}
--------------------------------------------------------------------------------
import System.Exit
import XMonad hiding ((|||))

import XMonad.Config.Desktop

import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.WorkspaceCompare
import XMonad.Util.NamedScratchpad
import XMonad.Util.Ungrab
import XMonad.Util.Loggers

import Data.Ratio ((%))
import Data.Maybe (maybeToList)

import Control.Monad

import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.SetWMName
import XMonad.Hooks.Place
import XMonad.Hooks.Focus
import XMonad.Hooks.DynamicLog

import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Shell

import XMonad.Actions.SpawnOn
import XMonad.Actions.CycleWS
import XMonad.Actions.FloatKeys

import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.ResizableTile
import XMonad.Layout.Grid
import XMonad.Layout.ZoomRow
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Gaps
import XMonad.Layout.IndependentScreens
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Magnifier

import qualified XMonad.StackSet as W

--------------------------------------------------------------------------------
-- | main
--
xmobar0 = statusBarPropTo "_XMONAD_LOG_1" "/usr/bin/xmobar -x 0 ~/.config/xmobar/xmobarrc1" (pure myXmobarPP)
xmobar1 = statusBarPropTo "_XMONAD_LOG_2" "/usr/bin/xmobar -x 1 ~/.config/xmobar/xmobarrc2" (pure myXmobarPP)
xmobar2 = statusBarPropTo "_XMONAD_LOG_3" "/usr/bin/xmobar -x 2 ~/.config/xmobar/xmobarrc3" (pure myXmobarPP)

xmobarSpawner :: ScreenId -> IO StatusBarConfig
xmobarSpawner 0 = pure $ xmobar0
xmobarSpawner 1 = pure $ xmobar1
xmobarSpawner 2 = pure $ xmobar2
xmobarSpawner _ = mempty -- nothing on the rest of the screens

main :: IO ()
main = xmonad
    . ewmhFullscreen
    . ewmh
    . setEwmhActivateHook myManageHook
    . withUrgencyHookC NoUrgencyHook myUrgentConfig
    . dynamicEasySBs xmobarSpawner
    $ myConfig

myConfig = def
    { modMask = mod4Mask
    , manageHook = myManageHook
    , terminal = "WINIT_X11_SCALE_FACTOR=1.2 alacritty"
    , normalBorderColor = "#0A0A0A"
    , focusedBorderColor = "#8fa1b3"
    , clickJustFocuses = False
    , workspaces = myWorkspaces
    , startupHook = myStartupHook >> setWMName "LG3D"
    , layoutHook = smartBorders $ myLayoutHook
    }
    `additionalKeysP` myKeyBindings

--------------------------------------------------------------------------------
-- | customize logging to xmobar
--
myXmobarPP :: PP
myXmobarPP = def
    { ppSep = xmobarColor "#81A1C1" "" " · "
    , ppTitle = xmobarColor "#aaaaaa" ""
    , ppTitleSanitize =  shorten 80 . xmobarStrip
    , ppCurrent = white . wrap " " "" . xmobarBorder "Top" "#ffffff" 1
    , ppHidden = white . wrap " " ""
    , ppVisible = xmobarColor "#999999" "" . wrap " " "" . xmobarBorder "Top" "#999999" 1
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent = red . wrap (white "!") (white "!")
    , ppSort = fmap (filterOutWs [scratchpadWorkspaceTag] .) $ ppSort def
    -- , ppExtras = [logTitles formatFocused formatUnfocused]
    -- , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    }
    where
        -- formatFocused = wrap (white "[") (white "]") . magenta . ppWindow
        -- formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue . ppWindow
        formatFocused = magenta . ppWindow
        formatUnfocused = " "

        -- | Windows should have *some* title, which should not not exceed a sane length.
        ppWindow :: String -> String
        ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 100

        blue, lowWhite, magenta, red, white, yellow :: String -> String
        magenta = xmobarColor "#ff79c6" ""
        blue = xmobarColor "#bd93f9" ""
        white = xmobarColor "#f8f8f2" ""
        yellow = xmobarColor "#f1fa8c" ""
        red = xmobarColor "#ff5555" ""
        lowWhite = xmobarColor "#555555" ""

--------------------------------------------------------------------------------
-- | definition of workspaces
--
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "NSP"]

--------------------------------------------------------------------------------
-- | definition of startup hooks
--
myStartupHook = do
    spawnOn "1" "bash -c 'WINIT_X11_SCALE_FACTOR=1.2 alacritty'"

--------------------------------------------------------------------------------
-- | customize the way 'XMonad.Prompt' looks and behaves
--
myXPConfig = def
    { position          = Bottom
    , alwaysHighlight   = True
    , searchPredicate   = fuzzyMatch
    , sorter            = fuzzySort
    , promptBorderWidth = 0
    , bgColor           = "#141414"
    , font              = "xft:Hack Nerd Font Mono:size=8"
    }

--------------------------------------------------------------------------------
-- | manipulate windows as they are created. The list given to
-- @composeOne@ is processed from top to bottom. The first matching rule wins.
--
myManageHook = composeOne
    [ className =? "Vncviewer" -?> doFloat
    , className =? "Microsoft Teams - Preview" -?> doShift "0"
    -- , isFullscreen -?> doFullFloat
    -- , isDialog -?> doCenterFloat
    , isDialog -?> doFloat
    , resource =? "Toolkit" -?> doFloat
    , transience
    ]
    <+> manageSpawn
    <+> manageDocks
    <+> namedScratchpadManageHook scratchpads
    <+> activateSwitchWs
    <+> insertPosition Below Newer
    <+> manageHook def

--------------------------------------------------------------------------------
-- | customize urgency hook
--
myUrgentConfig = UrgencyConfig
    { suppressWhen = Focused
    , remindWhen = Dont
    }

--------------------------------------------------------------------------------
-- | define workspace layouts
--
myLayoutHook = tile ||| mtile ||| grid ||| full ||| row ||| threeCol ||| mag
    where
        nmaster = 1      -- Default number of windows in the master pane
        ratio   = 1/2    -- Default proportion of screen occupied by master pane
        delta   = 3/100  -- Percent of screen to increment by when resizing panes

        mtile = renamed [Replace "[mtile]"] $
                -- gaps [ (L,2), (R,2) ] $
                windowNavigation $
                smartBorders $
                (Mirror $ ResizableTall nmaster delta ratio [])
        tile = renamed [Replace "[tile]"] $
                -- gaps [ (L,2), (R,2) ] $
                windowNavigation $
                smartBorders $
                ResizableTall nmaster delta ratio []
        grid = renamed [Replace "[grid]"] $
                -- gaps [ (L,2), (R,2) ] $
                windowNavigation $
                smartBorders $
                Grid
        full = renamed [Replace "[full]"] $
                -- gaps [ (L,2), (R,2) ] $
                noBorders $
                Full
        row = renamed [Replace "[row]"] $
                -- gaps [ (L,2), (R,2) ] $
                windowNavigation $
                smartBorders $
                zoomRow
        threeCol = renamed [Replace "[3col]"] $
                -- gaps [ (L,2), (R,2) ] $
                windowNavigation $
                smartBorders $
                ThreeColMid nmaster delta ratio
        mag = renamed [Replace "[mag]"] $
                -- gaps [ (L,2), (R,2) ] $
                windowNavigation $
                smartBorders $
                magnifier (ResizableTall nmaster delta ratio [])

--------------------------------------------------------------------------------
-- | scratchpad configurations (rect is -- from left, from top, width, height)
--
scratchpads =
    [ NS "calc" "speedcrunch -name calc_scratchpad" (resource =? "calc_scratchpad")
        (customFloating $ W.RationalRect 0.6 0.5 0.4 0.4)
    , NS "notes" "WINIT_X11_SCALE_FACTOR=1.2 alacritty --class notes_scratchpad -e nvim ~/notes.md" (resource =? "notes_scratchpad")
        (customFloating $ W.RationalRect 0.45 0.3 0.5 0.4)
    , NS "terminal" "WINIT_X11_SCALE_FACTOR=1.2 alacritty --class term_scratchpad" (resource =? "term_scratchpad")
        (customFloating $ W.RationalRect 0.45 0.3 0.5 0.4)
    ]

-- | hide scratchpad workspace (NSP) when cycling through workspaces
-- hiddenNotNSP = do
--     hs <- gets $ map W.tag . W.hidden . windowset
--     return (\w -> (W.tag w) /= "NSP" && (W.tag w) `elem` hs)

--------------------------------------------------------------------------------
-- | key bindings complementing and replacing defaults
--
myKeyBindings =
    [("M-S-q",                    confirmPrompt myXPConfig "[exit]" (io exitSuccess)) -- quit xmonad
    ,("M-q",                      confirmPrompt myXPConfig "[restart xmonad]" (spawn "xmonad --recompile && xmonad --restart")) -- restart xmonad
    ,("M-p",                      shellPrompt myXPConfig) -- open shell prompt

    ----------------------------------------------------------------------
    -- system control
    --
    ,("M-<End>",                  confirmPrompt myXPConfig "[poweroff]" (spawn "systemctl poweroff")) -- shutdown
    ,("M-S-<End>",                confirmPrompt myXPConfig "[hibernate]" (spawn "systemctl hibernate")) -- hibernate
    ,("S-<XF86Sleep>",            confirmPrompt myXPConfig "[hibernate]" (spawn "systemctl hibernate")) -- hibernate
    ,("M-C-<End>",                confirmPrompt myXPConfig "[hybrid sleep]" (spawn "systemctl hybrid-sleep")) -- hybrid sleep
    ,("M-<Home>",                 confirmPrompt myXPConfig "[reboot]" (spawn "systemctl reboot")) -- reboot
    ,("M-S-<Home>",               confirmPrompt myXPConfig "[suspend]" (spawn "systemctl suspend")) -- suspend to ram
    ,("<XF86Sleep>",              confirmPrompt myXPConfig "[suspend]" (spawn "systemctl suspend")) -- suspend to ram
    ,("<XF86MonBrightnessDown>",  spawn "brightnessctl s 10-") -- lower backlight
    ,("<XF86MonBrightnessUp>",    spawn "brightnessctl s +10") -- rise backlight
    ,("M-<Escape>",               spawn "i3lock --color=000000 --ring-color=440000 --ringver-color=200000 --ringwrong-color=200000 --keyhl-color=ff0000 --insidever-color=000000 --insidewrong-color=000000 --verif-color=ffffff --wrong-color=ffffff --modif-color=ffffff --line-uses-inside --indicator") -- lock screen

    ----------------------------------------------------------------------
    -- launch apps
    --
    ,("M-i",                      spawn "brave") -- launch browser
    ,("M-M1-i",                   spawn "brave --proxy-server='socks5://127.0.0.1:666'") -- launch browser
    ,("M-S-i",                    spawn "brave --incognito") -- launch browser for private browsing
    -- , ("M-<Print>",                spawn "import -window \"$(xdotool getwindowfocus -f)\" ~/$(date +%F_%H%M%S_%N).png") -- make a screenshot of the currently focused window
    -- , ("M-S-<Print>",              spawn "import -window root ~/$(date +%F_%H%M%S_%N).png") -- make a screenshot of entire screen
    ,("M-<Print>",                unGrab *> spawn "scrot -s") -- make a screenshot

    ----------------------------------------------------------------------
    -- audio control
    --
    ,("<XF86AudioRaiseVolume>",   spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%") -- volume up
    ,("<XF86AudioLowerVolume>",   spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%") -- volume down
    ,("<XF86AudioMute>",          spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle") -- toggle audio mute
    ,("<XF86AudioMicMute>",       spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle") -- toggle mic mute

    ,("M-<KP_Page_Up>",           spawn "pactl set-sink-volume 0 +5%; pactl set-sink-volume 1 +5%") -- volume up
    ,("M-<KP_Page_Down>",         spawn "pactl set-sink-volume 0 -5%; pactl set-sink-volume 1 -5%") -- volume down

    ----------------------------------------------------------------------
    -- window / layout control
    --
    ,("M-x",                      nextWS) -- switch to next workspace
    ,("M-S-x",                    shiftToNext >> nextWS) -- shift current window to next workspace
    ,("M-C-x",                    moveTo Next emptyWS) -- go to next empty workspace
    ,("M-y",                      prevWS) -- switch to previous workspace
    ,("M-S-y",                    shiftToPrev >> prevWS) -- shift current window to previous workspace
    ,("M-^",                      toggleWS) -- toggle to previous workspace
    ,("M-b",                      sendMessage ToggleStruts) -- toggle visibility of xmobar

    ,("M-<F8>",                   spawn "killall xss-lock") -- disable screen lock
    ,("M-<F9>",                   spawn "xrandr --output DP-0 --off --output HDMI-0 --mode 1920x1080 --rate 60")
    ,("M-S-<F9>",                 spawn "xrandr --output DP-0 --mode 1920x1080 --rate 144 --output HDMI-0 --off")
    ,("M-<F10>",                  spawn "xrandr --output eDP1 --auto --output DP2-1 --mode 3840x2160 --rate 30") -- enable dual (sync) display mode
    ,("<XF86Display>",            spawn "xrandr --output eDP1 --auto --output HDMI2 --auto") -- enable external display
    ,("S-<XF86Display>",          spawn "xrandr --output eDP1 --auto --output HDMI2 --off") -- display external display
    ,("M-<F11>",                  spawn "xrandr --output eDP1 --auto --output DP2-1 --mode 3840x2160 --rate 30 --right-of eDP1") -- enable extended desktop (extends right of main display)
    ,("M-S-<F11>",                spawn "xrandr --output eDP1 --auto --output DP2-1 --mode 3840x2160 --rate 30 --left-of eDP1") -- enable extended desktop (extends left of main display)

    ,("M-<F12>",                  confirmPrompt myXPConfig "[disable screensaver blanking]"
                                        (spawn "xset -display :0 -dpms;set -display :0 s noblank;xset -display :0 s noexpose;xset -display :0 s off")) -- disable screensaver blanking
    ,("M-S-<F12>",                confirmPrompt myXPConfig "[enable screensaver blanking]"
                                        (spawn "xset -display :0 +dpms;xset -display :0 s blank;xset -display :0 s expose;xset -display :0 s on")) -- enable screensaver blankinga

    ,("M-C-1",                    sendMessage $ JumpToLayout "[tile]")
    ,("M-C-2",                    sendMessage $ JumpToLayout "[mtile]")
    ,("M-C-3",                    sendMessage $ JumpToLayout "[grid]")
    ,("M-C-4",                    sendMessage $ JumpToLayout "[full]")
    ,("M-C-5",                    sendMessage $ JumpToLayout "[row]")
    ,("M-C-6",                    sendMessage $ JumpToLayout "[3col]")
    ,("M-C-7",                    sendMessage $ JumpToLayout "[mag]")

    ,("M-<Right>",                sendMessage $ Go R) -- navidate to window on the right
    ,("M-l",                      sendMessage $ Go R) -- navidate to window on the right
    ,("M-<Left>",                 sendMessage $ Go L) -- navigate to window on the left
    ,("M-h",                      sendMessage $ Go L) -- navigate to window on the left
    ,("M-<Up>",                   sendMessage $ Go U) -- navidate to window above
    ,("M-k",                      sendMessage $ Go U) -- navidate to window above
    ,("M-<Down>",                 sendMessage $ Go D) -- navigate to window below
    ,("M-j",                      sendMessage $ Go D) -- navigate to window below
    ,("M-M1-j",                   windows W.swapDown) -- swap the focused window with the next window
    ,("M-M1-k",                   windows W.swapUp) -- swap the focused window with the previous window
    ,("M-S-j",                    sendMessage MirrorShrink)
    ,("M-S-k",                    sendMessage MirrorExpand)
    ,("M-S-l",                    sendMessage Expand)
    ,("M-S-h",                    sendMessage Shrink)

    ,("M-d",                      withFocused(keysResizeWindow(20, 0) (1%2, 1%2)))
    ,("M-S-d",                    withFocused(keysResizeWindow(-20, 0) (1%2, 1%2)))
    ,("M-s",                      withFocused(keysResizeWindow(0, 20) (1%2, 1%2)))
    ,("M-S-s",                    withFocused(keysResizeWindow(0, -20) (1%2, 1%2)))
    ,("M-a",                      placeFocused(smart(1%2, 1%2)))

    ,("M-u",                      focusUrgent)
    ,("M-S-u",                    clearUrgents)
    ----------------------------------------------------------------------
    -- extra workspaces
    --
    ,("M-0",                      windows $ W.greedyView "0")
    ,("M-S-0",                    windows $ W.shift "0")

    ----------------------------------------------------------------------
    -- scratchpad bindings
    --
    ,("M-M1-s",                    namedScratchpadAction scratchpads "calc")
    ,("M-M1-n",                    namedScratchpadAction scratchpads "notes")
    ,("M-M1-t",                    namedScratchpadAction scratchpads "terminal")
    ]
    ++
    [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
        | (key, scr)  <- zip "wer" [2,0,1] -- was [0..] *** change to match your screen order ***
        , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
    ]

--------------------------------------------------------------------------------
-- | mupad fullscreen fix
--
--
addNETSupported :: Atom -> X ()
addNETSupported x = withDisplay $ \dpy -> do
    r <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a <- getAtom "ATOM"
    liftIO $ do
        sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
        when (fromIntegral x `notElem` sup) $
            changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]
