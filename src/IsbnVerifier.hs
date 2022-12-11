module IsbnVerifier (isbn) where

import Text.Read (readMaybe)
import Data.Maybe (fromMaybe)

-- isbn :: String -> Bool
isbn s 
  | length s' /= 10 = False
  | otherwise = sumOfValue `mod` 11 == 0
  where 
    s' = zip [10, 9..] $ filter (/= '-') s
    s'' = sequence $ isbn' s'
    s''' = sum <$> s''
    sumOfValue = fromMaybe 1 s'''

-- >>> isbn "3-598-21508-8"
-- >>> isbn "3-598-21508-9"
-- >>> isbn "3-598-21507-X"
-- >>> isbn "3-598-21507-A"
-- >>> isbn "3132P34035"
-- False
-- False
-- True
-- False
-- False

isbn' :: [(Int, Char)] -> [Maybe Int]
isbn' [] = []
isbn' [(a, b)]
  | b == 'X' = [Just (a * 10)]
  | otherwise = [(a *) <$> readMaybe [b]]
isbn' ((a, b):xs) = ((a *) <$> readMaybe [b]): isbn' xs

-- >>> readMaybe "A"
-- Nothing
