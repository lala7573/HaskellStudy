module Main (main) where

discard :: (a -> Bool) -> [a] -> [a]
discard p xs = [x | x <- xs, not $ p x]

-- >>> discard (==2) [1, 2, 3]
-- [1,3]


-- keep :: (a -> Bool) -> [a] -> [a]
-- keep p xs = error "You need to implement this function."

main :: IO()
main = undefined
