module Grains (square, total) where
-- https://exercism.org/tracks/haskell/exercises/grains/edit

import Data.Maybe (fromMaybe)
square :: Integer -> Maybe Integer
square n = if 1 <= n && n <= 64 then Just (2 ^ (n - 1)) else Nothing

-- >>> square 2
-- Just 2

total :: Integer
total = sum [fromMaybe 0 (square n) | n <- [1..64]]
-- >>> total
-- 18446744073709551615
