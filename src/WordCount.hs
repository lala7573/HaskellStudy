module WordCount (wordCount) where

-- https://exercism.org/tracks/haskell/exercises/word-count

import Data.List
import Data.Char (toLower)

-- wordCount
wordsWhen     :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'

removeQuote :: String -> String
removeQuote [] = []
removeQuote xs 
  | isQuoteStart = removeQuote $ tail xs 
  | isQuoteEnd = removeQuote $ init xs 
  | otherwise = xs
  where 
    isQuoteStart = head xs == '\''
    isQuoteEnd = last xs == '\''



wordCount :: [Char] -> [(String, Int)]
wordCount xs = (map (\x-> (head x, length x)) . group . sort . map removeQuote) $ wordsWhen (\x -> x `notElem` ('\'':['A' .. 'Z'] ++ ['a' .. 'z'] ++ ['0' .. '9'])) $ map toLower xs

-- >>> wordCount "\"That's the password: 'PASSWORD 123'!\", cried the Special Agent.\nSo I fled."
-- [("'password",1),("123'",1),("agent",1),("cried",1),("fled",1),("i",1),("password",1),("so",1),("special",1),("that's",1),("the",2)]

-- >>> wordCount "First: don't laugh. Then: don't cry."
-- [("cry",1),("don't",2),("first",1),("laugh",1),("then",1)]

-- >>> wordCount "Joe can't tell between 'large' and large."
-- [("and",1),("between",1),("can't",1),("joe",1),("large",2),("tell",1)]
