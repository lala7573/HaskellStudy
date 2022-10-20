module WordProblem (answer) where

import Data.List

data Expression = Value { int :: Integer } | Plus | Minus | Multiply | Divide deriving (Show, Eq)

calculate :: [Expression] -> [Expression]
calculate [Value a] = [Value a]
calculate ((Value a):Plus:(Value b):xs) = calculate $ Value (a + b):xs
calculate ((Value a):Minus:(Value b):xs) = calculate $ Value (a - b):xs
calculate ((Value a):Multiply:(Value b):xs) = calculate $ Value (a * b):xs
calculate ((Value a):Divide:(Value b):xs) = calculate $ Value (a `div` b):xs
calculate _ = []

fromExpression :: Maybe [Expression] -> Maybe Integer
fromExpression (Just [Value a]) = Just a
fromExpression _ = Nothing
-- >>> sequence [Just (Value {int = 5}),Just Plus,Just (Value {int = 10})]

-- >>> break isSpace "12 devided by"
-- ("12"," devided by")

answer :: String -> Maybe Integer
answer xs = fromExpression result 
  where
    result = calculate <$> sequence (answer' xs)

removePrefix str = drop (length str)

answer' :: String -> [Maybe Expression]
answer' xs
  | head xs == ' ' = answer' (tail xs)
  | head xs == '?' = []
  | "What is " `isPrefixOf` xs = answer' (removePrefix "What is " xs)
  | "plus " `isPrefixOf` xs = Just Plus:answer' (removePrefix "plus " xs)
  | "minus " `isPrefixOf` xs = Just Minus:answer' (removePrefix "minus " xs)
  | "multiplied by " `isPrefixOf` xs = Just Multiply:answer' (removePrefix "multiplied by " xs)
  | "divided by " `isPrefixOf` xs = Just Divide:answer' (removePrefix "divided by " xs)
  | not (null num) = Just (Value (read num :: Integer)): answer' next
  | otherwise = [Nothing]
  where
    (num, next) = span (`elem` '-':['0' .. '9']) xs

-- >>> span (`elem` '-':['0' .. '9']) "-122 3423"
-- ("-122"," 3423")

-- >>> Just $ Value (read "-122")
-- Just (Value {int = -122})

-- >>> answer "What is 5 plus 10?"
-- >>> answer "What is -1 plus -10?"
-- >>> answer' "What is 1 plus plus 2?"
-- Just 15
-- Just (-11)
-- [Just (Value {int = 1}),Just Plus,Just Plus,Just (Value {int = 2})]

-- >>> calculate <$> sequence [Just (Value {int = 1}),Just Plus,Just Plus,Just (Value {int = 2})]
-- Just []
