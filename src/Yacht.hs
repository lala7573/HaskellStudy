module Yacht (yacht, Category(..)) where

import Data.List
data Category = Ones
              | Twos
              | Threes
              | Fours
              | Fives
              | Sixes
              | FullHouse
              | FourOfAKind
              | LittleStraight
              | BigStraight
              | Choice
              | Yacht

yacht :: Category -> [Int] -> Int
yacht Ones dice = (sum . filter (==1)) dice
yacht Twos dice = (sum . filter (==2)) dice
yacht Threes dice = (sum . filter (==3)) dice
yacht Fours dice = (sum . filter (==4)) dice
yacht Fives dice = (sum . filter (==5)) dice
yacht Sixes dice = (sum . filter (==6)) dice
yacht FullHouse dice = if isFullHouse then sum dice else 0
  where
    dice' = (group . sort) dice
    isFullHouse = (length dice' == 2) && (length (head dice') == 2 || length (head dice') == 3)

yacht FourOfAKind dice = if null dice' then 0 else sum $ take 4 (head dice')
  where dice' = (filter (\x -> length x >= 4) . group . sort) dice
yacht LittleStraight dice = if isLittleStraight dice then 30 else 0
yacht BigStraight dice = if isBigStraight dice then 30 else 0
yacht Choice dice = sum dice
yacht Yacht dice = if len == 1 then 50 else 0
  where len = length $ group dice

-- >>> yacht LittleStraight [3, 5, 4, 1, 2]
-- >>> yacht FourOfAKind [3, 3, 3, 3, 3]
-- 15
-- 12

isLittleStraight dice = isLittleStraight' (sort dice)
isLittleStraight' [1, 2, 3, 4, 5] = True
isLittleStraight' _ = False

isBigStraight dice = isBigStraight' (sort dice)
isBigStraight' [2, 3, 4, 5, 6] = True
isBigStraight' _ = False
