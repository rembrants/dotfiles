-- Imports.
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Layout.SimplestFloat

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
--	{ layoutHook = lessBorders OnlyFloat $ myLayout 
--                 , borderWidth = 4
--                 , normalBorderColor  = "#000000i"
--                 , focusedBorderColor = "#f48024"
--                 }

-- Command to launch the bar.
-- myBar = "xmobar"
myBar = "xmobar"

myWorkspaces = ["1:main*", "2:shell", "3:log", "4:storage-log", "5:program-log"]

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#00d800" "" . wrap "" "" }


-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = defaultConfig { modMask = mod1Mask
  , layoutHook = myLayout
  , workspaces = myWorkspaces
  , terminal = "st"
--  , borderWidth = 0
--  , normalBorderColor="#000000"
--  , focusedBorderColor="#e6f6ff"
  }
  `additionalKeysP`
  [
--("M-p", spawn "rofi -show run -lines 5 -width 100 -padding 100 -fullscreen -opacity '85' -font 'roboto 50' separator-style 'none'")
  ("M-p", spawn "dmenu_run -b -nb '#000000' -nf '#333333' -sb '#000000' -sf '#ffffff' -fn 'bebas kai-9' -p '$'")
 , ("M-m", spawn "xinput -enable 11 && xinput -enable 12")
 , ("M-S-m", spawn "xinput -disable 11 && xinput -disable 12")
  ]

myLayout = tiled ||| Mirror tiled ||| noBorders Full 
--myLayout = tiled ||| Mirror tiled ||| noBorders Full ||| noBorders simplestFloat 
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
