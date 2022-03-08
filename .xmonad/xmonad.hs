-- Imports.
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
myBar = "xmobar"

myWorkspaces = ["1", "2", "3", "4", "5"]

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#00d800" "" . wrap "" "" }


-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = defaultConfig { modMask = mod1Mask
  , layoutHook = myLayout
  , workspaces = myWorkspaces
  , terminal = "xterm"
  }
  `additionalKeysP`
  [
  ("M-p", spawn "rofi -show run -theme dmenu")
  ]

myLayout = tiled ||| Mirror tiled ||| noBorders Full 
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
