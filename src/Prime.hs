module Prime (nth) where
-- https://exercism.org/tracks/haskell/exercises/nth-prime

-- .. 못품
nth :: Int -> Maybe Integer
nth n 
    | n > 0 = Just $ primes !! (n - 1)
    | otherwise = Nothing
primes :: [Integer]
primes = sieve [2..]
    where
        sieve [] = []
        sieve (p:ps) = p : sieve [x | x <- ps, x `mod` p /= 0]
       

nth_failed :: Int -> Maybe Integer
nth_failed n 
  | n <= 0 = Nothing
  | n == 1 = Just 2
  | otherwise = Just $ ([x | x <- 2:3:5:[7, 11 ..], isPrime x]) !! (n-1)

isPrime n 
  | n == 2 = True
  | otherwise = all (\x -> n `mod` x /= 0) $ 2:3:5:[7, 11 ..]

