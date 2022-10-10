module Acronym (abbreviate) where
-- https://exercism.org/tracks/haskell/exercises/acronym/edit

import Data.Char
import qualified Data.Text as T
import           Data.Text (Text)

extractAbbr :: [Char] -> [Char]
extractAbbr [] = []
extractAbbr s@(x:xs) = if all isUpper s then [x] else x:filter isUpper xs

abbreviate xs = map toUpper $ concatMap (extractAbbr. T.unpack) (T.splitOn (T.pack " ") (T.pack (map (\x -> if x `elem` "-_" then ' ' else x) xs)))
-- >>> T.SplitOn [T.pack " ", T.pack "-"] "Complementary metal-oxide semiconductor""


-- >>> abbreviate "Portable Network Graphics"
-- >>> abbreviate "Ruby on Rails"
-- >>> abbreviate "HyperText Markup Lang"
-- >>> abbreviate "GNU Image Manipulation Program"
-- >>> abbreviate "Complementary metal-oxide semiconductor"
-- "PNG"
-- "ROR"
-- "HTML"
-- "GIMP"
-- "CMOS"
