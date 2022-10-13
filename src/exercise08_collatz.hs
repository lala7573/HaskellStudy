
collatz :: Integer -> Maybe Integer
collatz n = collatz' n 0
collatz' :: Integer -> Integer -> Maybe Integer
collatz' n acc
 | n == 1 = Just acc
 | n `mod` 2 == 0 = collatz' (n `div` 2) (acc + 1) 
 | otherwise = collatz' (3 * n + 1) (acc + 1) 
