module OCR (convert) where

import Data.List.Split (chunksOf)
import Data.List (intercalate, transpose)

convert :: String -> String
convert xxs = maybe "" (intercalate ",") (mapM convert' (chunksOf 4 $ lines xxs))
convert' :: [String] -> Maybe String
convert' xxs = mapM parseOCR xxs'
  where xxs' = transpose $ map (chunksOf 3) xxs

-- >>> chunksOf 4 [ "    _  _ ", "  | _| _|", "  ||_  _|", "         ", "    _  _ ", "|_||_ |_ ", "  | _||_|", "         ", " _  _  _ ", "  ||_||_|", "  ||_| _|", "         " ]
-- [["    _  _ ","  | _| _|","  ||_  _|","         "],["    _  _ ","|_||_ |_ ","  | _||_|","         "],[" _  _  _ ","  ||_||_|","  ||_| _|","         "]]

-- >>> transpose $ map (chunksOf 3) ["123123", "456456"]
-- [["123","456"],["123","456"]]

-- >>> convert' [ "    _  _     _  _  _  _  _  _ ", "  | _| _||_||_ |_   ||_||_|| |", "  ||_  _|  | _||_|  ||_| _||_|", "                              " ]
-- [Just '1',Just '2',Just '3',Just '4',Just '5',Just '6',Just '7',Just '8',Just '9',Just '0']

parseOCR :: [String] -> Maybe Char
parseOCR xxs
  | equalOCR xxs [ " _ ", "| |", "|_|", "   " ] = Just '0'
  | equalOCR xxs [ "   ", "  |", "  |", "   " ] = Just '1'
  | equalOCR xxs [ " _ ", " _|", "|_ ", "   " ] = Just '2'
  | equalOCR xxs [ " _ ", " _|", " _|", "   " ] = Just '3'
  | equalOCR xxs [ "   ", "|_|", "  |", "   " ] = Just '4'
  | equalOCR xxs [ " _ ", "|_ ", " _|", "   " ] = Just '5'
  | equalOCR xxs [ " _ ", "|_ ", "|_|", "   " ] = Just '6'
  | equalOCR xxs [ " _ ", "  |", "  |", "   " ] = Just '7'
  | equalOCR xxs [ " _ ", "|_|", "|_|", "   " ] = Just '8'
  | equalOCR xxs [ " _ ", "|_|", " _|", "   " ] = Just '9'
  | otherwise = Just '?'
  where equalOCR xs ys = all (==True) $ zipWith (==) xs ys
-- >>> [ " _ ", "| |", "|_|", "   " ] == [ " _ ", "| |", "|_|", "   " ]
-- [" _ ","| |","|_|","   "]
