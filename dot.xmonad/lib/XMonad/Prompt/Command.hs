module XMonad.Prompt.Command (commandPrompt, CommandPrompt) where
import XMonad.Prompt
import XMonad.Core (X)
import Data.List
import XMonad.Util.Run (unsafeSpawn)

data CommandPrompt = CommandPrompt
instance XPrompt CommandPrompt where
  showXPrompt _ = "Command: "
  nextCompletion _ input compls = compls !! nextIdx
    where
      nextIdx =
        case input `elemIndex` compls of
          Just idx
            | idx >= length compls - 1 -> 0
            | otherwise -> idx + 1
          Nothing -> 0

commandPrompt :: [String] -> XPConfig -> X ()
commandPrompt commands xpconfig = do
  mkXPrompt CommandPrompt xpconfig (mkComplFun commands) $ \selection ->
    unsafeSpawn selection
  where
    mkComplFun :: [String] -> String -> IO [String]
    mkComplFun candidates input = return $ filter (input `isInfixOf`) candidates
