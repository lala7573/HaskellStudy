module Study06 (main) where

main = undefined
-- # Algebraic Data type
-- data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving Show
-- -- Circle :: Float -> Float -> Float -> Shape
-- -- Rectangle :: Float -> Float -> Float -> Float -> Shape

-- surface :: Shape -> Float
-- surface (Circle _ _ r) = pi * r ^ 2
-- surface (Rectangle x1 y1 x2 y2) = abs $ (x2 - x1) * (y2 - y1)

-- >>> map (Circle 10 20) [4, 5, 6, 6]
-- [Circle 10.0 20.0 4.0,Circle 10.0 20.0 5.0,Circle 10.0 20.0 6.0,Circle 10.0 20.0 6.0]

-- # Record Syntax
-- data Person = Person String String Int String deriving (Show)
-- firstname (Person firstname _ _ _) = firstname
-- lastname :: Person -> String
-- lastname (Person _ lastname _ _) = lastname
-- age (Person _ _ age _) = age
-- address (Person _ _ _ address) = address

-- data Person = Person { firstname:: String, lastname:: String, age:: Int, address:: String} deriving (Show, Eq)
-- -- >>> let joe = Person "joe" "test" 30 "somewhere good"
-- -- >>> firstname joe
-- -- >>> joe == Person "joe" "test" 30 "somewhere good"
-- -- "joe"
-- -- True


-- data Circle = Circle { origin:: (Int, Int), radius:: Int} deriving (Show)
-- -- >>> let c = Circle {radius = 5, origin=(0,0) }
-- -- >>> origin c
-- -- (0,0)

-- type Point = (Int, Int)

-- distance :: Floating a => (a, a) -> (a, a) -> a
-- distance (x1, y1) (x2, y2) = sqrt $ (x2 - x1)^2 + (y2 - y1)^2

-- data List a = Empty | Cons a (List a) deriving (Show, Read, Eq, Ord)
-- -- >>> 5 `Cons` Empty
-- -- >>> 4 `Cons` (5 `Cons` Empty)
-- -- Cons 5 Empty
-- -- Cons 4 (Cons 5 Empty)

-- -- >>> 4 `Cons` 5 `Cons` Empty
-- -- Non type-variable argument in the constraint: Num (List a)
-- -- (Use FlexibleContexts to permit this)

-- data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

-- # typeclass
-- data TrafficLight = Red | Yellow | Green
-- instance Eq TrafficLight where
--   Red == Red = True
--   Green == Green = True
--   Yellow == Yellow = True
--   _ == _ = False

-- class (Eq a) => Ord a where
--   compare :: a -> a -> Ordering

-- -- binary search tree 과제..
-- data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read)

-- instance (Eq a) => Eq (Tree a) where
--   EmptyTree == EmptyTree = True
--   Node a a1 a2  == Node b b1 b2 = (a == b) && (a1 == b1) && (a2 == b2) 
--   _ == _ = False

-- -- >>> Node 1 EmptyTree
-- -- No instance for (Show (Tree Integer -> Tree Integer))
-- --   arising from a use of ‘evalPrint’
-- --   (maybe you haven't applied a function to enough arguments?)

-- create a = Node a EmptyTree EmptyTree

-- -- >>> create 1
-- -- Node 1 EmptyTree EmptyTree

-- insert :: (Ord a) => Tree a -> a -> Tree a
-- insert EmptyTree a = create a
-- insert node@(Node value left right) x 
--   | x == value = node
--   | x < value = Node value (insert left x) right
--   | otherwise = Node value left (insert right x)

-- search :: (Ord a) => Tree a -> a -> Bool
-- search EmptyTree _ = False
-- search (Node value left right) x
--   | x == value = True
--   | x < value = search left x
--   | otherwise = search right x


-- main:: IO()
-- main = undefined
