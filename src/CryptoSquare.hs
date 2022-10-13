module CryptoSquare (encode) where

import Data.List
import Data.Char (toLower, isSpace)

trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isSpace

padding :: Int -> String -> [Char]
padding n value = value ++ replicate lenPadding ' '
  where
    lenPadding = n - length value

getAlpha :: [Char] -> [Char]
getAlpha = filter (`elem` alpha)
  where alpha = ['a' .. 'z'] ++ ['A' .. 'Z'] ++ ['0' .. '9']

lower = map toLower

encode xs
  | xs == "" = []
  | otherwise = unwords $ transpose chunked
  where
    xs' = (lower . getAlpha) xs
    len = length xs'
    r = head [x | x <- [1..], x * (x + 1) >= len]
    c = head [x | x <- [r..], r * x >= len]
    chunked = map (padding c) (chunk c xs')

-- >>> encode ""
-- >>> encode "B"
-- >>> encode "Chill out."
-- ""
-- "b"
-- "clu hlt io "


-- >>> encode "If man was meant to stay on the ground, god would have given us roots."
-- ["ifmanwas","meanttos","tayonthe","groundgo","dwouldha","vegivenu","sroots  "]

chunk :: Int -> [a] -> [[a]]
chunk _ [] = []
chunk n xs
  | n > 0 = headXs: chunk n tailXs
  | otherwise = error "Negative or zero n"
  where
    headXs = take n xs
    tailXs = drop n xs

