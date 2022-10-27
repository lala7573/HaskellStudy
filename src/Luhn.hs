module Luhn (isValid) where
-- https://exercism.org/tracks/haskell/exercises/luhn

import Data.Char (isSpace, digitToInt)

getOdds n = map snd $ filter (odd . fst) $ zip [0..] n
getEvens n = map snd $ filter (even . fst) $ zip [0..] n

isValid n =  (evens + odds) `mod` 10 == 0 && len > 1
  where
    n' = filter (not.isSpace) $ reverse n
    len = length n'
    evens = sum $ map digitToInt $ getEvens n'
    odds = sum $ map ((\x -> if x*2 > 9 then x*2-9 else x*2) . digitToInt) $ getOdds n'

-- >>> isValid "0"
-- >>> isValid "4539 3195 0343 6467"
-- (43,37)

