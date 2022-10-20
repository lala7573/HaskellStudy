module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance [] [] = Just 0
distance [] _ = Nothing
distance _ [] = Nothing
distance (x:xs) (y:ys) 
  | x /= y = (+1) <$> distance xs ys 
  | otherwise = distance xs ys


-- >>> distance "A" "A"
-- Just 1

-- >>> distance "GAGCCTACTAACGGGAT" "CATCGTAATGACGGCCT"
-- Just 7
