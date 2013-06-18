module XMonad.Util.WindowTitle (changeWindowTitle) where
import XMonad

changeWindowTitle :: Window -> String -> X ()
changeWindowTitle win str = do
  wmName <- getAtom "_NET_WM_NAME"
  withDisplay $ \dpy -> io $ do
    setTextProperty dpy win str wmName
    setTextProperty dpy win str wM_NAME
  return ()
