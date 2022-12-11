module Triangle (TriangleType(..), triangleType) where

-- https://exercism.org/tracks/haskell/exercises/triangle

data TriangleType = Equilateral
                  | Isosceles
                  | Scalene
                  | Illegal
                  deriving (Eq, Show)

triangleType :: (Num a, Ord a) => a -> a -> a -> TriangleType
triangleType a b c  
  | isTriagle && a == b && b == c = Equilateral
  | isTriagle && (a == b || a == c || b == c) = Isosceles
  | isTriagle = Scalene
  | otherwise = Illegal
  where 
    a' = minimum [a, b, c]
    c' = maximum [a, b, c]
    b' = sum [a, b, c] - a' - c'
    isTriagle = a' + b' >= c' && (a > 0 && b > 0 && c > 0)
  
-- >>> triangleType 3 4 4 
-- 7 > 8 | 
