module LinkedList
    ( LinkedList
    , datum
    , fromList
    , isNil
    , new
    , next
    , nil
    , reverseLinkedList
    , toList
    ) where

data LinkedList a = Nil | LinkedList a (LinkedList a) deriving (Eq, Show)

datum :: LinkedList a -> a
datum (LinkedList a _) = a

fromList :: [a] -> LinkedList a
fromList = foldr LinkedList Nil

isNil :: LinkedList a -> Bool
isNil Nil = True
isNil _ = False

new :: a -> LinkedList a -> LinkedList a
new = LinkedList

-- >>> datum $ next $ fromList [2, 1 :: Int]
-- >>> fromList [2, 1 :: Int]
-- 1
-- LinkedList 2 (LinkedList 1 Nil)

next :: LinkedList a -> LinkedList a
next (LinkedList a l) = l

nil :: LinkedList a
nil = Nil

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList Nil = Nil
reverseLinkedList (LinkedList a n) = reverseLinkedList' a (reverseLinkedList n)

reverseLinkedList' x Nil = LinkedList x Nil
reverseLinkedList' x (LinkedList a n) = LinkedList a (reverseLinkedList' x n)

-- >>> datum $ next $ fromList [2, 1 :: Int]
-- >>> reverseLinkedList $ new 3 $ fromList [2, 1 :: Int]
-- >>> datum $ reverseLinkedList $ fromList [2, 1 :: Int]
-- 1
-- LinkedList 1 (LinkedList 2 (LinkedList 3 Nil))
-- 1

toList :: LinkedList a -> [a]
toList Nil = []
toList (LinkedList a l) = a:toList l
