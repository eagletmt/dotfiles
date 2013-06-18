module XMonad.Prompt.Goto (gotoPrompt, GotoPrompt) where
import XMonad.Prompt
import XMonad.Actions.WindowBringer (windowMap)
import XMonad.Core (X)
import XMonad.Operations (windows)
import qualified XMonad.StackSet as W
import Data.List
import qualified Data.Map as M

data GotoPrompt = GotoPrompt
instance XPrompt GotoPrompt where
  showXPrompt _ = "Window: "
  nextCompletion _ input compls = compls !! nextIdx
    where
      nextIdx =
        case input `elemIndex` compls of
          Just idx
            | idx >= length compls - 1 -> 0
            | otherwise -> idx + 1
          Nothing -> 0

gotoPrompt :: XPConfig -> X ()
gotoPrompt xpconfig = do
  wm <- windowMap
  mkXPrompt GotoPrompt xpconfig (mkComplFun (M.keys wm)) $ \selection ->
    case M.lookup selection wm of
      Just win -> windows $ W.focusWindow win
      Nothing -> return ()
  where
    mkComplFun :: [String] -> String -> IO [String]
    mkComplFun candidates input = return $ filter (input `isInfixOf`) candidates
