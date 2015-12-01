import XMonad
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Dzen
import XMonad.Util.NamedWindows(getName)
import System.Exit
import XMonad.Actions.UpdatePointer
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Hooks.DynamicLog
import XMonad.Prompt
import XMonad.Hooks.UrgencyHook
import Data.Ratio --required for withIM layout
import Data.List -- for isSuffixOf

main = do
    xmonad $ defaultConfig
        { layoutHook = avoidStruts $ myLayout
        -- Don't put borders on fullFloatWindows
        , manageHook = myManageHooks
        , modMask = mod4Mask --Rebind mod to Windows key
	, terminal = "urxvt -e bash -c 'tmux attach -t local || tmux new -s local'"
        , keys = myKeys
	, borderWidth = 5
	, normalBorderColor = "#2900b2"
	, focusedBorderColor = "#ffe600"
	, workspaces = myWorkspaces
	, focusFollowsMouse = True
        , logHook = updatePointer (Relative 0.06 0.06)
        }
	`additionalKeysP`
	myKeysP

imLayout = withIM (1%7) ((ClassName "Skype") `And` (Not (Title "Options")) `And` (Not (Role "ConversationsWindow")) `And` (Not (Role "CallWindow"))) Grid
layouts = smartBorders(Tall 1 (3/100) (1/2) ||| noBorders Full)
myLayout = onWorkspace "9" imLayout $ layouts

myManageHooks = composeAll
-- Allows focusing other monitors without killing the fullscreen
    --[ isFullscreen --> (doF W.focusDown <+> doFullFloat)
    [ isFullscreen -->  doFullFloat
 
-- Single monitor setups, or if the previous hook doesn't work
    --, isFullscreen --> doFullFloat

    ,className    =? "Firefox"    --> doShift "2:web"
    ,className    =? "Chromium"   --> doShift "2:web"
    ,className    =? "Goldendict" --> doShift "2:web"
    ,className    =? "Skype"      --> doShift "9"
    ,className    =? "MPlayer"    --> doShift "5:mov"
    ,resource     =? "vlc"        --> doShift "5:mov"
    ,className    =? "feh"        --> doShift "5:mov"
    ,resource     =? "emacs"      --> doShift "3:emacs"
    ,className    =? "Zenity"     --> doFloat
    ,className    =? "Gimp"       --> doFloat
    ,className    =? "Xmessage"   --> doCenterFloat
    , (resource =? "Download" <&&> className =? "Namoroka") --> doCenterFloat
    ,manageDocks]

myWorkspaces = ["1:terminal", "2:web", "3:emacs", "4", "5:mov", "6", "7", "8", "9"]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    -- , ((modm,               xK_semicolon     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ((modm, xK_semicolon ), spawn "dmenu_run -i")

    -- close focused window
    , ((modm, xK_m     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_k     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_n     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_e     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_l     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_n     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_e     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_y     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_o     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_b     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
    ]
    ++

    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_exclam,
                                                  xK_at,
                                                  xK_numbersign,
                                                  xK_dollar,
                                                  xK_percent,
                                                  xK_asciicircum,
                                                  xK_ampersand,
                                                  xK_asterisk,
                                                  xK_parenleft]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_d, xK_r, xK_w] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myKeysP = [("<XF86AudioLowerVolume>", spawn "amixer set Master 3%-")
	 ,("<XF86AudioRaiseVolume>", spawn "amixer set Master 3%+")
	 ,("<XF86AudioMute>", spawn "amixer set Master toggle")
	 ,("M-<F2>", spawn "cmus-remote -u")  -- Play/Pause
	 ,("M-<F3>", spawn "cmus-remote -n")  -- Next Track
         ,("S-<XF86HomePage>", spawn "cmus_add_queue")
	 ,("M-h", spawn "date +%H:%M | osd_cat - -d1 -f'-*-terminus-bold-*-*-*-32-320-*-*-*-*-*-*'")
         ,("M-s", spawn "date +'%a:%d %b:%m' | osd_cat - -d3 -f'-*-terminus-bold-*-*-*-32-320-*-*-*-*-*-*'")
	 ,("M-S-p", spawn "gen_pass.sh")
	 ,("M-C-p", spawn "gen_pass.sh -n")
         ,("M-<F12>", spawn "pomodoro")
	 -- Reset keyboard layout to workman before locking the screen.
	 ,("M-S-l", spawn "setxkbmap -layout workman-p; slock; setxkbmap -layout workman-p,ru")
	 ,("M-q", spawn "xmonad --recompile && xmonad --restart")
         ,("M-S-C-q", io (exitWith ExitSuccess))
         ,("M-f", spawn "tmux select-pane -t :.+")
         ,("M-u", spawn "tmux select-pane -t :.-")
	 ,("<XF86Back>", spawn "amixer set Master 3%-")
	 ,("<XF86Forward>", spawn "amixer set Master 3%+")
	 ,("<XF86HomePage>", spawn "cmus-remote -u")
	 ,("C-<XF86HomePage>", spawn "cmus-remote -n")
   ,("<XF86Sleep>", spawn "systemctl suspend")
	 ]
