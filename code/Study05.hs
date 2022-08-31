module Main (main) where

x a b c = a + b + c

-- >>> 3 `x` 4 5
-- Non type-variable argument in the constraint: Num (t -> a)
-- (Use FlexibleContexts to permit this)

-- >>> (3 `x`) 4 5
-- 12

-- >>> (3 `x` 4) 5
-- 12

test = (`x` 3)
-- >>> 3 `test` 3
-- 9
divideByTen = (`div` 10)

-- >>> divideByTen 23
-- 2

applyTwice :: (t -> t) -> t -> t
applyTwice f x = f (f x)

-- >>> applyTwice (+3) 10
-- >>> applyTwice (++ " HAHA") "HEY"
-- >>> applyTwice ("HAHA " ++) "HEY"
-- >>> applyTwice (3:) [1]
-- 16
-- "HEY HAHA HAHA"
-- "HAHA HAHA HEY"
-- [3,3,1]

mkTuple a b = (a, b)
zip' = zipWith mkTuple

-- >>> zipWith (zipWith (*)) [[1,2,3], [2,3]] [[3,2,2],[4,5]]
-- [[3,4,6],[8,15]]

map2 :: (t -> a) -> [t] -> [a]
map2 _ [] = []
map2 f (x:xs) = f x: map2 f xs

-- >>> map2 (+3) [1..5]
-- >>> map2 (3+) [1..5]
-- >>> map2 (replicate 3) [3..6]
-- >>> map2 fst [(1,2),(9,5),(3,7),(4,6)]
-- [4,5,6,7,8]
-- [4,5,6,7,8]
-- [[3,3,3],[4,4,4],[5,5,5],[6,6,6]]
-- [1,9,3,4]

filter2 :: (a -> Bool) -> [a] -> [a]
filter2 _ [] = []
filter2 p (x:xs)
  | p x = x : filter2 p xs
  | otherwise = filter2 p xs

-- >>> filter2 (>3) [1,5,3,1,1,6,4,2]
-- >>> filter2 even [1..10]
-- >>> filter2 (`elem` ['a'..'z']) "abAFYUAkwfyunA"
-- [5,6,4]
-- [2,4,6,8,10]
-- "abkwfyun"

-- >>> map (\x -> x + 3) [1..5]
-- >>> filter (\x -> x `mod` 3 == 0 || x `mod` 5 == 0) [1..5]
-- [4,5,6,7,8]
-- [3,5]

inverse = map (1/)
-- >>> inverse [1,2,4,5]
-- [1.0,0.5,0.25,0.2]

-- 타입가드 써서 만들기
longList1 :: [[a]] -> [[a]]
longList1 [] = []
longList1 (x:xs)
  | length x >= 3 = x:longList1 xs
  | otherwise = longList1 xs
-- >>> longList1 [[1,2,3,4,5], [1,2], [], [1,2,3,4], [1]]
-- [[1,2,3,4,5],[1,2,3,4]]

-- filter 써서 만들기
-- filter (a->Bool) -> [a] -> [b]
longList2 :: [[a]] -> [[a]]
longList2 = filter2 (\x -> length x >= 3)
-- >>> longList2 [[1,2,3,4,5], [1,2], [], [1,2,3,4], [1]]
-- [[1,2,3,4,5],[1,2,3,4]]



productVector (x1,y1) (x2,y2) = x1 * x2 + y1 * y2
dot = zipWith productVector
-- >>> dot [(1,2), (3,5)] [(4,7), (6,8)]
-- [18,58]
dot2 = zipWith (\ (x1, y1) (x2, y2) -> x1 * x2 + y1 * y2)
-- >>> dot2 [(1,2), (3,5)] [(4,7), (6,8)]
-- [18,58]

foldl2 :: (b -> a -> b) -> b -> [a] -> b
foldl2 f acc [] = acc
foldl2 f acc (x:xs) = foldl2 f (f acc x) xs

sum' :: (Num a) => [a] -> a
sum' xs = foldl2 (\acc x -> acc + x) 0 xs
-- >>> sum' [1,2,3]
-- 6

elem' x xs = foldl (\acc y -> if y == y then True else acc) False xs
map3 f xs = foldr (\x acc -> f x:acc) [] xs
-- >>> map3 (+3) [1..5]
-- >>> map3 (3+) [1..5]
-- >>> map3 (replicate 3) [3..6]
-- >>> map3 fst [(1,2),(9,5),(3,7),(4,6)]
-- [4,5,6,7,8]
-- [4,5,6,7,8]
-- [[3,3,3],[4,4,4],[5,5,5],[6,6,6]]
-- [1,9,3,4]
filter3 p xs = foldr (\x acc -> if p x then x:acc else acc) [] xs
-- >>> filter3 (>3) [1,5,3,1,1,6,4,2]
-- >>> filter3 even [1..10]
-- >>> filter3 (`elem` ['a'..'z']) "abAFYUAkwfyunA"
-- [5,6,4]
-- [2,4,6,8,10]
-- "abkwfyun"
product3 xs = foldl (*) 1 xs


-- >>> sum (map (+3) [1..100])
-- >>> sum $ map (+3) [1..100]
-- >>> sum (map (+3) (filter even [1..100]))
-- >>> sum $ map (+3) $ filter even [1..100]
-- 5350
-- 5350
-- 2700
-- 2700

-- >>> map ($3) [(4+), (10*), (^2)]
-- [7,30,9]


allNegate xs = map (\x -> negate (abs x)) xs

allNegate' xs = map (negate . abs) xs


foo xs = map (\x -> negate (sum (tail x))) xs
foo' xs = map (negate . sum . tail) xs
-- >>> foo' [[1..5], [3..6],[1..7]]
-- [-14,-15,-27]

-- fn x = ceiling (negate (tan (cos (max 50 x))))
fn = ceiling . negate . tan . cos . max 50


-- finalPosition
finalPosition :: Num a => (a, a) -> [(a, a)] -> (a, a)
finalPosition = foldl (\(a1, b1) (a2, b2) -> (a1 + a2, b1 + b2))
-- >>> finalPosition (3, 5) [(1,1), (-1,2), (2,4)]
-- (5,12)


-- nineDigit
nineDigit num = nineDigit' (show num)
nineDigit' = length . filter (== '9')
-- >>> nineDigit 9991235719913
-- 5

nineDigit2 :: (Integral a, Show a, Integral b) => a -> b
nineDigit2 = fromIntegral . length . filter (=='9') . show

main:: IO()
main = undefined
