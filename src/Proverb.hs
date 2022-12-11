module Proverb(recite) where
import Data.List (intercalate)

-- recite :: [String] -> String
recite [] = ""
recite w@(x:_) = intercalate "\n" $ recite' w x
recite' :: [String] -> String -> [String]
recite' [_] h = ["And all for the want of a " ++ h ++ "."]
recite' (a:b:xs) h
  = ("For want of a " ++ a ++ " the " ++ b ++ " was lost."):recite' (b:xs) h

-- >>> recite ["nail"]
-- >>> recite ["nail", "shoe", "horse", "rider", "message", "battle", "kingdom"]
-- "And all for the want of a nail."
-- "For want of a nail the shoe was lost.\nFor want of a shoe the horse was lost.\nFor want of a horse the rider was lost.\nFor want of a rider the message was lost.\nFor want of a message the battle was lost.\nFor want of a battle the kingdom was lost.\nAnd all for the want of a nail."


