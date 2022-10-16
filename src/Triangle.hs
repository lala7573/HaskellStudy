module Triangle (rows) where

rows :: Int -> [[Integer]]
rows x
  | x == 0 = []
  | x == 1 = [[1]]
  | x == 2 = [[1], [1, 1]]
  | otherwise = prev ++ [zipWith (+) l n]
    where
      prev = rows (x-1)
      l = last prev ++ [0]
      n = 0:l ++ [1]

-- >>> rows 0
-- >>> rows 1
-- >>> rows 2
-- >>> rows 3
-- []
-- [[1]]
-- [[1],[1,1]]
-- [[1],[1,1],[1,2]]
