module Main (main) where

main :: IO()
main = undefined

-- map :: (a -> b) -> [a] -> [b]
-- map =  f x: map f xs

mmapf f = mmapf
  where 
    mapf (x:xs) = f x: map f xs
    mmapf (y:ys) = mapf y: map mapf ys

-- map f (x:xs) = f x: map f xs
mapmap f ((x:xs):xss) = (map . map) f ((x:xs):xss)
-- (map . map) 
-- 함수의 결합: (map . map) 의 첫번째 파라미터는 (a->b) 임
-- = (a->b) -> map ([a] -> [b])
-- = (a->b) -> [[a]] -> [[b]]

-- map f (x:xs) = f x: map f xs
-- (map . map)
-- = map . (\(f (x:xs)) -> f x: map f xs)
-- = f x: map f xs


-- No instance for (Show ([a0] -> (a0 -> b0) -> [b0]))
--   arising from a use of ‘evalPrint’
--   (maybe you haven't applied a function to enough arguments?)

-- >>> (map . map [1, 2, 3] (+))  [4, 5, 6]
-- Couldn't match expected type ‘[a3] -> a -> b’
--             with actual type ‘[b0]’
-- Couldn't match expected type ‘a0 -> b0’ with actual type ‘[a1]’
-- Couldn't match expected type ‘[a0]’
--             with actual type ‘a2 -> a2 -> a2’
  
-- = map 

-- mapmap = (map $ map)
-- = map map
-- = map ((a->b) -> [a]->[b])
-- = [(a->b)] -> [[a] -> [b]]





