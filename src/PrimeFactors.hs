module PrimeFactors (primeFactors) where

primeFactors :: Integer -> [Integer]
primeFactors n = primeFactors' n 2

primeFactors' :: Integer -> Integer -> [Integer]
primeFactors' 1 x = []
primeFactors' n x 
    | n <= 1 = []
    | n == x = [n]
    | r == 0 = x:primeFactors' p x
    | otherwise = primeFactors' n (x+1)
    where (p, r) = n `divMod` x

-- >>> primeFactors 1
-- >>> primeFactors 2
-- >>> primeFactors 9
-- >>> primeFactors 8
-- []
-- [2]
-- [3,3]
