module Poker (main) where

import Data.List

data Suit = Club | Heart | Diamond | Spade deriving (Show, Enum)
data Rank = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King | Ace deriving (Show, Enum, Eq, Ord)
data Card = Card { suit:: Suit, rank:: Rank } deriving (Show)
type Deck = [Card]

data Hand = HighCard | OnePair | TwoPairs | Trips | Straight | Flush | FullHouse | Quads | StraightFlush deriving (Show, Enum, Eq, Ord)

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

-- >>> map suit [(Card Spade Two), (Card Club Three), (Card Club Two)]
-- [Spade,Club,Club]

-- >>> [Two .. Ace]
-- [Two,Three,Four,Five,Six,Seven,Eight,Nine,Ten,Jack,Queen,King,Ace]


isFlush suits = ((== 5) . length . filter (== head suits)) suits

isStraight :: [Rank] -> Bool
isStraight ranks
        | ranks == [Two, Three, Four, Five, Ace] = True
        | otherwise = ranks == orders
        where orders = take 5 [head ranks .. Ace]

hand deck
  | length deck == 5 = Just (hand' deck)
  | otherwise = Nothing
hand' :: Deck -> Hand
hand' deck
  | isStraight ranks && isFlush suits = StraightFlush
  | isStraight ranks = Straight
  | isFlush suits = Flush
  | [1, 4] == cntPair = Quads
  | [2, 3] == cntPair = FullHouse
  | [1, 2, 2] == cntPair = TwoPairs
  | [1, 1, 1, 2] == cntPair = OnePair
  | otherwise = HighCard
  where suits = map suit deck
        ranks = (sort . map rank) deck
        grouped = group ranks
        cntPair = sort $ concat $ (group . map length) grouped

-- >>> hand [(Card Club Two), (Card Club Three), (Card Club Four), (Card Club Five), (Card Club Ace)]
-- >>> hand [(Card Club Ten), (Card Club Three), (Card Club Four), (Card Club Five), (Card Club Ace)]
-- >>> hand [(Card Club Two), (Card Club Two), (Card Club Two), (Card Club Two), (Card Spade Ace)]
-- Just StraightFlush
-- Just Flush
-- Just Quads

-- >>> StraightFlush < Quads
-- False

versus :: Deck -> Deck -> String
versus p1 p2 = versus' (hand p1) (hand p2)
versus' (Just h1) (Just h2) = if h1 > h2 then "p1 win" else "p2 win"
versus' _ _ = "invalid"
  
-- >>> versus [(Card Club Two), (Card Club Two), (Card Club Two), (Card Club Two), (Card Spade Ace)] [(Card Club Ten), (Card Club Three), (Card Club Four), (Card Club Five), (Card Club Ace)]
-- >>> versus [(Card Club Ten), (Card Club Three), (Card Club Four), (Card Club Five), (Card Club Ace)] [(Card Club Two), (Card Club Three), (Card Club Four), (Card Club Five), (Card Club Ace)] 
-- "p1 win"
-- "p2 win"

main:: IO()
main = undefined
