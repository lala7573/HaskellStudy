module SumOfMultiples (sumOfMultiples) where
-- https://exercism.org/tracks/haskell/exercises/sum-of-multiples/edit

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = sum [x | x <- [1..limit-1],  any (\f -> x `mod` f == 0) (filter (/=0) factors)]
-- >>> sumOfMultiples [3, 5] 20
-- >>> sumOfMultiples [0, 5] 20
-- 78
-- 30
