module Change (findFewestCoins) where

import Data.Maybe (listToMaybe)

findFewestCoins :: Integer -> [Integer] -> Maybe [Integer]
findFewestCoins target coins = listToMaybe $ getCoins target coins

-- >>> listToMaybe [1, 2, 3]
-- Just 1

-- >>> getCoins 21 [2, 5, 10]
-- [[2,2,2,5,10],[2,2,2,5,5,5],[2,2,2,2,2,2,2,2,5]]

getCoins :: Integer -> [Integer] -> [[Integer]]
getCoins _ [] = []
getCoins target (x:xs)
  | target < 0 = []
  | target == 0 = [[]]
  | otherwise = getCoins target xs ++ ((x:) <$> getCoins (target-x) (x:xs))
