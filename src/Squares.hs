module Squares (difference, squareOfSum, sumOfSquares) where

difference :: Integral a => a -> a
difference n = squareOfSum n - sumOfSquares n 

squareOfSum :: Integral a => a -> a
squareOfSum n = s ^ (2 :: Integer)
  where s = sum [1..n]

sumOfSquares :: Integral a => a -> a
sumOfSquares n = (sum . map (^(2 :: Integer))) [1..n]
