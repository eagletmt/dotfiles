module XMonad.Util.ToggleMinimize (toggleMinimizeWindow) where
import XMonad
import XMonad.Layout.Minimize
import XMonad.Util.WindowProperties (getProp32)
import Data.Maybe (fromMaybe)

toggleMinimizeWindow :: Window -> X ()
toggleMinimizeWindow win = do
  wm_state <- getAtom "_NET_WM_STATE"
  mini <- getAtom "_NET_WM_STATE_HIDDEN"
  wstate <- fromMaybe [] `fmap` getProp32 wm_state win
  if fromIntegral mini `elem` wstate then
    sendMessage $ RestoreMinimizedWin win
  else
    minimizeWindow win
