-- Imports.
import XMonad
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Layout.ResizableTile
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
--import XMonad.Layout.Spiral
--import XMonad.Layout.ThreeColumns
--import XMonad.Layout.Grid
--import XMonad.Layout.MultiColumns
import XMonad.Layout.Renamed

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
myBar = "xmobar"

myWorkspaces = ["1:www", "2:sys", "3:dev", "4:doc"]

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#aaaaaa" "" . wrap "[" "]" }


-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = def { modMask = mod1Mask
  , layoutHook = myLayout
  , workspaces = myWorkspaces
  , terminal = "xterm" 
  , handleEventHook = handleEventHook def <+> Hacks.windowedFullscreenFixEventHook
  }

  `additionalKeysP` 
  [
  ("M-p", spawn "rofi -show run -theme dmenu -display-run 'Run '")
  , ("M-c", spawn "chromium")
  , ("M-x", spawn "pyxtrlock")
  , ("M-z", sendMessage MirrorShrink)
  , ("M-a", sendMessage MirrorExpand)
  ]

--myLayout = tiled ||| Mirror tiled ||| layout_spiral ||| layout_threecol ||| layout_grid ||| layout_multicol ||| noBorders Full 
myLayout = tiled ||| Mirror tiled ||| noBorders Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = renamed [Replace "Tall"] $ ResizableTall 1 (3/100) (1/2) []
     --tiled   = Tall nmaster delta ratio

     --layout_spiral = spiral (6/7)
     --layout_threecol = ThreeCol 1 (3/100) (1/2)
     --layout_grid = Grid
     --layout_multicol = multiCol [1] 1 0.01 (-0.5)

     -- The default number of windows in the master pane
     --nmaster = 1

     -- Default proportion of screen occupied by master pane
     --ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     --delta   = 3/100
