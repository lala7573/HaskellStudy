module Study01_03 (doubleIf, even2, factorial, lastButOne, notCapital, diff, sum, swap, divisors) where

-- import Prelude (IO)

doubleIf x = if x < 100 then x * 2 else 2
even2 x = x `mod` 2 == 0
factorial n = if n == 0 then 1 else factorial (n - 1) * n


lastButOne list = head (tail (reverse list)) -- init (last list)
notCapital str = [x | x <- str, x `elem` ['a'..'z']]
diff aList bList = [a | a <- aList, a `notElem` bList]


swap lst = [(snd x, fst x) | x <- lst]
sum' lst = if null lst then 0 else head lst + sum' (tail lst)
divisors n= [x | x <- [1.. n], n `mod` x == 0]


-- main :: IO
main = undefined