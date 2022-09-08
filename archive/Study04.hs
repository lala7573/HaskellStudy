-- module Main (main, listToPairs, trueman, yesNo) where

-- f :: (Integral a) => a -> String
-- f n = "must run this function!"
-- f 0 = "it's 0"

-- f2 :: (Integral a) => a -> String
-- f2 0 = "it's 0"
-- f2 n = "must run this function!"


-- yesNo :: Bool -> String
-- yesNo True = "yes"
-- yesNo False = "no"
-- -- >>> yesNo True
-- -- "yes"
-- -- >>> yesNo False
-- -- "no"

-- trueman :: [Bool] -> Int
-- trueman [] = 0
-- trueman (True:xs) = 1 + trueman xs
-- trueman (False:xs) = 0 + trueman xs
-- -- >>> trueman []
-- -- 0
-- -- >>> trueman [True, False, True]
-- -- 2

-- listToPairs :: [a] -> [(a, a)]
-- listToPairs [] = []
-- listToPairs [_] = []
-- listToPairs (x1:x2:xs) =  (x1, x2):listToPairs xs
-- -- >>> listToPairs [1,2,3,4,5]
-- -- [(1,2),(3,4)]

-- calcFibos :: (Integral a) => [a] -> [a]
-- calcFibos xs = [fibo x | x <- xs]
--   where fibo 0 = 0
--         fibo 1 = 1
--         fibo n = fibo (n-1) + fibo (n-2)
-- -- >>> calcFibos [1,2,3, 4, 5, 6, 7]
-- -- [1,1,2,3,5,8,13]

-- -- >>> [f x | x <-[0..10], let f 0 = 0; f 1 = 1; f n = f(n-1) + f(n-2)]
-- -- [0,1,1,2,3,5,8,13,21,34,55]

-- describeList :: [a] -> [Char]
-- describeList xs = case xs of
--   [] -> "The list is empty"
--   [x] -> "The list has one element"
--   xs -> "The list has " ++ show (length xs) ++ " elements"
-- -- >>> describeList [1]
-- -- >>> describeList [1, 2, 3]
-- -- "The list has one element"
-- -- "The list has 3 elements"

-- maximum' [] = error "empty list"
-- maximum' [a] = a
-- maximum' (x:xs)
--   | x > y = x
--   | otherwise = y
--   where y = maximum' xs
-- -- >>> maximum [1,2,3,4,5]
-- -- 5

-- -- take' 0 _ = []
-- -- take' 1 x:xs = [x]
-- -- take' n x:xs = x:(take' (n-1) xs)
-- take' _ [] = []
-- take' n _ | n <= 0 = []
-- take' n (x:xs) = x:take' (n-1) xs
-- -- >>> take' 0 [1]
-- -- >>> take' 5 [1]
-- -- >>> take' 4 [1,2,3,4,5,6]
-- -- []
-- -- [1]
-- -- [1,2,3,4]

-- zip' _ [] = []
-- zip' [] _ = []
-- zip' (x:xs) (y:ys) = (x, y):zip' xs ys
-- -- >>> zip' [1,2,3] [4,5,6]
-- -- [(1,4),(2,5),(3,6)]

-- quickSort [] = []
-- quickSort [a] = [a]
-- quickSort (x:xs) = quickSort [s | s<- xs, s < x] ++ [x] ++ quickSort [b | b<- xs, b >= x] 
-- -- >>> quickSort [1,4,7,2,3,5,8]
-- -- [1,2,3,4,5,7,8]

-- main:: IO()
-- main = undefined
