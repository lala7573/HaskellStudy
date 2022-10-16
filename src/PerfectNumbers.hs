module PerfectNumbers (classify, Classification(..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

-- classify :: Int -> Maybe Classification
classify num 
  | num <= 0 = Nothing
  | sumOfValues == num = Just Perfect
  | sumOfValues < num = Just Deficient
  | otherwise = Just Abundant
  where sumOfValues = sum [x | x <- [1 .. num-1], num `mod` x == 0]

sumOfValues num = [x | x <- [1 .. num-1], num `mod` x == 0]
-- >>> classify 6
-- Just Perfect
