-- Imports.
import XMonad
import XMonad.ManageHook
import XMonad.Hooks.ManageHelpers
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Layout.ResizableTile
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.InsertPosition
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
import XMonad.Layout.MultiColumns
import XMonad.Layout.Grid
import XMonad.Layout.Renamed
import XMonad.Layout.Magnifier
import XMonad.Layout.PerWorkspace
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.BorderResize
import XMonad.Actions.SpawnOn
import XMonad.Actions.UpdatePointer
import XMonad.Actions.SwapPromote

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
myBar = "xmobar"

myWorkspaces = ["1", "2", "3", "4"]

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#aaaaaa" "" . wrap "[" "]" }


-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = def { modMask = mod1Mask
  , layoutHook = myLayout
--  , normalBorderColor = "#00ffff"
  , normalBorderColor = "#000000"
--  , focusedBorderColor = "#ff00ff"
  , focusFollowsMouse = True
  , workspaces = myWorkspaces
  , terminal = "xterm" 
  , handleEventHook = handleEventHook def <+> Hacks.windowedFullscreenFixEventHook
  , manageHook = insertPosition End Newer <+> manageSpawn <+> manageHook def <+> (className =? "wlclock" --> doIgnore)
  --, manageHook = insertPosition End Newer <+> manageSpawn <+> manageHook def <+> (className =? "org.poul.wlclock" --> doIgnore)
  ,logHook = updatePointer (0.5, 0.5) (0, 0) -- exact centre of window
   >> masterHistoryHook
  }

  `additionalKeysP` 
  [
  ("M-p", spawn "rofi -show run -theme dmenu -display-run '$'")
  , ("M-<Return>", swapPromote' False)
  , ("M-z", sendMessage MirrorShrink)
  , ("M-a", sendMessage MirrorExpand)
  ]


--myLayout = onWorkspace "1" tiled$
myLayout = 
          tiled ||| Mirror tiled  |||  noBorders Full
          -- noBorders Full ||| tiled ||| layoutThreecol ||| layoutSpiral ||| borderResize emptyBSP ||| Grid ||| Mirror tiled
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled     = renamed [Replace "Tall"] $ ResizableTall 1 (3/100) (1/2) []
     layoutMirror    = renamed [Replace "Mirror"] $ smartBorders $ Mirror $ ResizableTall 1 (3/100) (85/100) []
     --layoutMagnifier	 = lessBorders Screen $ maximizeVertical $ (Tall 1 (3/100)(60/100))
     --layoutMagnifier	 = renamed [Replace "Magnifier"] $ lessBorders Screen $ magnifiercz' 1.4 (Tall 1 (3/100)(60/100))
     --layoutSpiral 	 = spiral (6/7)
     --layoutThreecol 	 = ThreeCol 1 (3/100) (1/2)
     --layoutMulticol 	 = multiCol [1] 1 0.01 (-0.5)

     --tiled   = Tall nmaster delta ratio
     
     -- The default number of windows in the master pane
     --nmaster = 1
    
     -- Percent of screen to increment by when resizing panes
     --delta   = 3/100
     
     -- Default proportion of screen occupied by master pane
     --ratio   = 1/2

 --myManageHook = composeAll
 --   [ className =? "Wayland Clock" --> doF W.swapDown
 --   , className =? "Wayland Clock" --> doIgnore
 --   , isFullscreen --> doFullFloat
 --   ] 
