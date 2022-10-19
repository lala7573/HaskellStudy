module Queens (boardString, canAttack) where

import Data.List (intersperse, intercalate)

-- https://exercism.org/tracks/haskell/exercises/queen-attack

equal :: (Int, Int) -> Maybe (Int, Int) -> Bool
equal _ Nothing = False
equal p (Just q) = p == q

boardString :: Maybe (Int, Int) -> Maybe (Int, Int) -> String
boardString white black = 
    unlines board
  where
    draw (x, y)
      | equal (x, y) white = 'W'
      | equal (x, y) black = 'B'
      | otherwise = '_'
    board = [intersperse ' ' [draw (y, x) | x <- [0..7]] | y <- [0..7]]

-- >>> boardString (Just (1, 1)) Nothing
-- "_ _ _ _ _ _ _ _\n_ W _ _ _ _ _ _\n_ _ _ _ _ _ _ _\n_ _ _ _ _ _ _ _\n_ _ _ _ _ _ _ _\n_ _ _ _ _ _ _ _\n_ _ _ _ _ _ _ _\n_ _ _ _ _ _ _ _\n"
canAttack :: (Int, Int) -> (Int, Int) -> Bool
canAttack (ax, ay) (bx, by)
  | ax == bx = True
  | ay == by = True
  | otherwise = 1 == abs ((by - ay) `div` (bx - ax))

-- >>> canAttack (2, 3) (5, 6)
-- True

