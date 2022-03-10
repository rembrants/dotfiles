-- Imports.
import XMonad
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Layout.ResizableTile
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
myBar = "xmobar"

myWorkspaces = ["1:www", "2:shell", "3:qgj", "4:owk", "5:ls"]

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#00d800" "" . wrap "" "" }


-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = def { modMask = mod1Mask
  , layoutHook = myLayout
  , workspaces = myWorkspaces
  , terminal = "xterm -fn '-*-lucidatypewriter-medium-*-*-10-*-*-*-*-*-*-*' -fg white -bg black" 
  , handleEventHook = handleEventHook def <+> Hacks.windowedFullscreenFixEventHook
  }

  `additionalKeysP` 
  [
  ("M-p", spawn "rofi -show run -theme dmenu")
  , ("M-w", spawn "chromium")
  , ("M-z", sendMessage MirrorShrink)
  , ("M-a", sendMessage MirrorExpand)
  ]

myLayout = tiled ||| Mirror tiled ||| noBorders Full 
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = ResizableTall 1 (3/100) (1/2) []
     --tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     --nmaster = 1

     -- Default proportion of screen occupied by master pane
     --ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     --delta   = 3/100
