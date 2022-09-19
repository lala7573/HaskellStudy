module Main (main) where

import Data.List

data Suit = Club | Heart | Diamond | Spade deriving (Show, Enum)
data Rank = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King | Ace deriving (Show, Enum, Eq, Ord)
data Card = Card { suit:: Suit, rank:: Rank } deriving (Show)
type Deck = [Card]

data Hand = HighCard | OnePair | TwoPairs | Trips | Strait | Flush | FullHouse | Quads | StraightFlush deriving (Show, Enum)

instance Eq Suit where
  (==) Club Club = True
  (==) Heart Heart = True
  (==) Diamond Diamond = True
  (==) Spade Spade = True
  (==) _ _ = False

-- >>> Club == Club
-- >>> Heart == Heart
-- >>> Diamond == Diamond
-- >>> Spade == Spade
-- >>> Club == Heart
instance Ord Suit where
  compare a b 
    | a == b = EQ
    | a == Club = LT
    | b == Club = GT
    | a == Heart = LT
    | a == Diamond = LT
    | a == Spade = LT
    | otherwise = GT

-- >>> compare Club Club
-- >>> compare Club Heart
-- >>> compare Club Diamond
-- >>> compare Club Spade
-- >>> compare Club Club
-- >>> compare Heart Club
-- >>> compare Diamond Club
-- >>> compare Spade Club

instance Eq Card where
  Card s1 r1 == Card s2 r2 = s1 == s2 && r1 == r2
instance Ord Card where
  compare (Card s1 r1) (Card s2 r2) 
    | s1 == s2 = compare r1 r2
    | otherwise = compare s1 s2
-- >>> compare (Card Club Two) (Card Club Ace)
-- >>> compare (Card Club King) (Card Club King)
-- >>> compare (Card Club King) (Card Club Queen)

-- >>> sort [(Card Spade Two), (Card Club Three), (Card Club Two)]
-- [Card {suit = Club, rank = Two},Card {suit = Club, rank = Three},Card {suit = Spade, rank = Two}]

-- >>> foldl1 (\acc c -> acc == c) map suit [(Card Spade Two), (Card Club Three), (Card Club Two)]
-- Couldn't match expected type ‘(Card -> Suit) -> [Card] -> t’
--             with actual type ‘Bool’
-- Couldn't match type ‘[a0] -> [b0]’ with ‘Bool’
-- Expected type: (a0 -> b0) -> Bool
--   Actual type: (a0 -> b0) -> [a0] -> [b0]

-- arrangeBySuit deck = map () [Club .. Spade]

-- isFlush deck = foldl (==) (map suit deck)
-- hand :: Deck -> Bool
-- hand a = hand' (sort a)
-- hand' 
--   | 

main:: IO()
main = undefined


-- >>> compare (Card Club Ace) (Card Club King)
-- GT


-- instance Ord Card (suit, rank) where
  
-- compare :: Deck -> Deck -> Bool
-- compare a b = undefined


-- sortDeck :: Deck -> Deck
-- sortDeck deck = sort deck


