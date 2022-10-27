module MapMap (main) where

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

