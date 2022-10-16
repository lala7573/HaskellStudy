module CryptoSquare (encode) where

import Data.List
import Data.Char (toLower, isSpace)

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
    r = ceiling $ sqrt $ fromIntegral len
    c = len `div` r
    chunked = map (padding c) (chunk c xs')

chunk :: Int -> [a] -> [[a]]
chunk _ [] = []
chunk n xs
  | n > 0 = headXs: chunk n tailXs
  | otherwise = error "Negative or zero n"
  where
    headXs = take n xs
    tailXs = drop n xs

