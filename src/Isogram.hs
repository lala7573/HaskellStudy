module Isogram (isIsogram) where

-- https://exercism.org/tracks/haskell/exercises/isogram/edit
import Data.Char (toLower)
import Data.List (sort, group)

normalize = map toLower . filter (not. (`elem` ['-', '_', ' ']))
-- isIsogram :: String -> Bool
isIsogram word = all (\x -> length x == 1) $ (group . sort) $ normalize word

-- >>> isIsogram "Alphabet"
-- False


