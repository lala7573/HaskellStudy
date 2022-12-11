module Series (Error(..), largestProduct) where
import Text.Read (readMaybe)
import Data.Maybe (isNothing)
import Data.Char(digitToInt)

data Error = InvalidSpan | InvalidDigit Char deriving (Show, Eq)

largestProduct :: Int -> String -> Either Error Int
largestProduct size digits
    | size == 0 = Right 1
    | size < 0 = Left InvalidSpan
    | len < size = Left InvalidSpan
    | isNothing check =  Left $ InvalidDigit $ head $ filter (not . flip elem ['0'..'9']) digits
    | otherwise = Right $ largestProduct' size digits
    where
        len = length digits
        check = readMaybe digits :: Maybe Int

largestProduct' :: Int -> [Char] -> Int
largestProduct' size digits'
    | length digits < size = 0
    | otherwise = max (product $ take size digits) (largestProduct' size (tail digits'))
    where digits = map digitToInt digits'
-- >>> largestProduct' 2 "0123456789"
-- 72
