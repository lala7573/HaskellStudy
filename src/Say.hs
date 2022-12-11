module Say (inEnglish) where

import Data.Char (isSpace)

trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isSpace

inEnglish :: Integer -> Maybe String
inEnglish n
    | n < 0 = Nothing
    | n == 0 = Just "zero"
    | otherwise = Just s
    where s = (unwords . map (\x -> (trim. unwords) [snd x, fst x]). reverse.  filter (\x -> snd x /= ""). zip ["", "thousand", "million", "billion"] . map ((unwords . readThreeNumber) . reverse) . chunk 3 . reverse. show) n

-- readChunks x:xs 
--     | 
-- >>> inEnglish 0
-- Just "zero"

chunk :: Int -> [a] -> [[a]]
chunk _ [] = []
chunk n xs
  | n > 0 = headXs: chunk n tailXs
  | otherwise = error "Negative or zero n"
  where
    headXs = take n xs
    tailXs = drop n xs

-- >>> ( map (\x -> (trim. unwords) [snd x, fst x]). reverse. filter (\x -> snd x /= ""). zip ["", "thousand", "million", "billion"] . map unwords. map readThreeNumber . map reverse. chunk 3 . reverse. show) 1000000
-- ["one million"]

readThreeNumber s@(x:xs)
    | n >= 100 = [readNumber h, "hundred"] ++ readThreeNumber xs
    | otherwise = [readNumber n]
    where
        n = read s
        h = read [x]


readNumber :: (Show a, Integral a) => a -> [Char]
readNumber n
    | n == 1 = "one"
    | n == 2 = "two"
    | n == 3 = "three"
    | n == 4 = "four"
    | n == 5 = "five"
    | n == 6 = "six"
    | n == 7 = "seven"
    | n == 8 = "eight"
    | n == 9 = "nine"
    | n == 10 = "ten"
    | n == 11 = "eleven"
    | n == 12 = "twelve"
    | n == 13 = "thirteen"
    | n == 14 = "fourteen"
    | n == 15 = "fifteen"
    | n == 16 = "sixteen"
    | n == 17 = "seventeen"
    | n == 18 = "eighteen"
    | n == 19 = "nineteen"
    | q == 2 = "twenty" ++ if r == 0 then [] else '-':readNumber r
    | q == 3 = "thirty" ++ if r == 0 then [] else '-':readNumber r
    | q == 4 = "forty" ++ if r == 0 then [] else '-':readNumber r
    | q == 5 = "fifty" ++ if r == 0 then [] else '-':readNumber r
    | q == 6 = "sixty" ++ if r == 0 then [] else '-':readNumber r
    | q == 7 = "seventy" ++ if r == 0 then [] else '-':readNumber r
    | q == 8 = "eighty" ++ if r == 0 then [] else '-':readNumber r
    | q == 9 = "ninty" ++ if r == 0 then [] else '-':readNumber r
    | otherwise = ""
    where (q, r) = n `divMod` 10
