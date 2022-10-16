module Minesweeper (annotate) where

import Data.Char (intToDigit)

sumOf3List = (zipWith3 . zipWith3) (\a b c -> a + b + c)

mark mine =
  sumOf3List sumOfTop sumOfCurr sumOfDown
  where
    dummy = replicate (length $ head mine) 0
    sumOfTop = mark' $ tail mine ++ [dummy]
    sumOfCurr = mark' mine
    sumOfDown = dummy : mark' mine

mark' mine = sumOf3List left curr right
  where
  left = map ((++[0]) . tail) mine
  curr = mine
  right = map ((0:) . init) mine

annotate :: [String] -> [String]
annotate board
  | board == [""] = [""]
  | otherwise = renderMap board marked
  where
    mine = (map. map) (\x -> if x == '*' then 1 else 0) board
    marked = (map . map) intToDigit $ mark mine

renderMap :: [[Char]] -> [[Char]] -> [[Char]]
renderMap = (zipWith . zipWith) render

render b n
  | b == '*' = '*'
  | n == '0' = ' '
  | otherwise = n

-- >>> annotate [""]
-- >>> annotate [ "111", "1*1", "111" ]
-- [""]
-- ["111","1*1","111"]

