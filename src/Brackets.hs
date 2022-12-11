module Brackets (arePaired) where

arePaired :: String -> Bool
arePaired xs' = null $ arePaired' xs []
    where
        xs = filter (`elem` "[]{}()") xs'

pair '(' = ')'
pair '[' = ']'
pair '{' = '}'

arePaired' :: [Char] -> [Char] -> [Char]
arePaired' [] q = q
arePaired' (x:xs) qs
    | x `elem` "[{(" = arePaired' xs (pair x:qs)
    | null qs = "invalid"
    | otherwise = if head qs == x then arePaired' xs (tail qs) else "invalid"


-- >>> arePaired' "}{" []
-- Prelude.head: empty list

-- >>> filter (flip elem "[]{}()") "{}[a"
-- "{}["
