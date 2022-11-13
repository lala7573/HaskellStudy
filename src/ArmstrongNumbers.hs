module ArmstrongNumbers (armstrong) where

armstrong :: Integral a => a -> Bool
armstrong num = toInteger num == sum (map (^ len) digits)
  where 
    digits = toDigit num
    len = length digits


toDigit :: Integral a => a -> [Integer]
toDigit = reverse . toDigit' . toInteger 
toDigit' num 
  | num < 10 = [num]
  | otherwise = r:toDigit' q
    where (q, r) = num `divMod` 10

-- >>> armstrong 9
-- >>> armstrong 10
-- >>> armstrong 153
-- >>> armstrong 154
-- True
-- False
-- True
-- False

