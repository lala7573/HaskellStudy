module ResistorColors (Color(..), Resistor(..), label, ohms) where

import Data.List
import Data.List.Split

data Color =
    Black
  | Brown
  | Red
  | Orange
  | Yellow
  | Green
  | Blue
  | Violet
  | Grey
  | White
  deriving (Show, Enum, Bounded)

newtype Resistor = Resistor { bands :: (Color, Color, Color) }
  deriving Show

colorToNum :: Color -> Int
colorToNum = fromEnum

-- humanReadableUnit :: String -> String
humanReadableUnit v 
  | not isLeadingZero = v ++ " ohms"
  | len == 1 = remains ++ " kiloohms"
  | len == 2 = remains ++ " megaohms"
  | len == 3 = remains ++ " gigaohms"
  | otherwise = "undefined"
  where 
    x = group $ chunksOf 3 $ reverse v
    isLeadingZero = head (head x) == "000"
    len = length $ head x
    remains = take (length v - len * 3) v

-- >>> humanReadableUnit "0"
-- "0 ohms"

label :: Resistor -> String
label resistor = humanReadableUnit value
  where 
    value = show $ ohms resistor
-- >>> label $ Resistor (Black,Black,Black)
-- "0"

ohms :: Resistor -> Int
ohms resistor = ohms' $ bands resistor
ohms' (a, b, c) = (colorToNum a * 10 + colorToNum b) * 10 ^ colorToNum c
