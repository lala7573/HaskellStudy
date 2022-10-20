module Robot
    ( Bearing(East,North,South,West)
    , bearing
    , coordinates
    , mkRobot
    , move
    ) where

import Data.List (group)

data Bearing = North
             | East
             | South
             | West
             deriving (Eq, Show, Enum)

next :: Bearing -> Bearing
next West = North
next b = succ b

prev:: Bearing -> Bearing
prev North = West
prev b = pred b

-- >>> map prevBearing [North .. West]
-- [West,North,East,South]

data Robot = Robot { bearing :: Bearing, coordinates :: (Integer, Integer) }

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot = Robot

-- RAALAL
move :: Robot -> String -> Robot
move robot [] = robot
move robot instructions = move' robot zipped
  where
    zipped = (map ((,) <$> head <*> length) . group) instructions

move' :: Robot -> [(Char, Int)] -> Robot
move' robot [] = robot
move' robot (x:xs)
  | i == 'A' = move' (mkRobot bearing' (advance bearing' coordinates' n)) xs
  | i == 'L' = move' (mkRobot ((recursive prev n) bearing') coordinates') xs
  | i == 'R' = move' (mkRobot ((recursive next n) bearing') coordinates') xs
  where
    bearing' = bearing robot
    coordinates' = coordinates robot
    i = fst x
    n = snd x

recursive :: (b -> b) -> Int -> b -> b
recursive f n = foldr (.) id (replicate n f)

advance :: Bearing -> (Integer, Integer) -> Int -> (Integer, Integer)
advance bearing' (x, y) n'
  | bearing' == North = (x, y + n)
  | bearing' == East = (x + n, y)
  | bearing' == West = (x - n, y)
  | otherwise = (x, y - n)
  where 
    n = fromIntegral n'
