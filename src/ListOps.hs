{-# LANGUAGE DeriveAnyClass #-}
-- > https://exercism.org/tracks/haskell/exercises/list-ops
module ListOps
  ( length
  , reverse
  , map
  , filter
  , foldr
  , foldl'
  , (++)
  , concat
  ) where

import Prelude hiding
  ( length, reverse, map, filter, foldr, (++), concat )

foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' _ z [] = z
-- ??? 뭐지 ???
foldl' f z (x:xs) = seq acc' foldl' f acc' xs
  where acc' = f z x

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _ z [] = z
foldr f z (x:xs) = f x (foldr f z xs)

length :: [a] -> Int
length = foldl (\acc _ -> acc+1) 0 

reverse :: [a] -> [a]
reverse = foldl (flip (:)) []

map :: (a -> b) -> [a] -> [b]
map f = foldr (\x acc -> f x: acc) []

filter :: (a -> Bool) -> [a] -> [a]
filter p = foldr (\x acc -> if p x then x:acc else acc) []

(++) :: [a] -> [a] -> [a]
xs ++ ys = foldr (:) ys xs

concat :: [[a]] -> [a]
concat = foldr (++) []
