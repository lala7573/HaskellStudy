module BST
    ( BST
    , bstLeft
    , bstRight
    , bstValue
    , empty
    , fromList
    , insert
    , singleton
    , toList
    ) where

-- https://exercism.org/tracks/haskell/exercises/binary-search-tree

data BST a = Nil | Node (BST a) a (BST a) deriving (Show)
instance (Eq a) => Eq (BST a) where
  Nil == Nil = True
  (Node l1 v1 r1) == (Node l2 v2 r2) = v1 == v2 && l1 == l2 && r1 == r2
bstLeft :: BST a -> Maybe (BST a)
bstLeft Nil = Nothing
bstLeft (Node l _ _) = Just l
bstRight :: BST a -> Maybe (BST a)
bstRight Nil = Nothing
bstRight (Node _ _ r) = Just r
bstValue :: BST a -> Maybe a
bstValue Nil = Nothing
bstValue (Node _ v _) = Just v
empty :: BST a
empty = Nil
fromList :: Ord a => [a] -> BST a
fromList [] = empty
fromList xs = foldr insert empty $ reverse xs
insert :: Ord a => a -> BST a -> BST a
insert x Nil = singleton x
insert x (Node l v r)
  | x <= v = case l of
    Nil -> Node (singleton x) v r
    _ -> Node (insert x l) v r
  | otherwise = case l of
    Nil -> Node l v (singleton x)
    _ -> Node l v (insert x r)
singleton :: a -> BST a
singleton x = Node Nil x Nil
toList :: BST a -> [a]
toList Nil = []
toList (Node l v r) = toList l ++ [v] ++ toList r