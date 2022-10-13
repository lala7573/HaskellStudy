module NucleotideCounts (nucleotideCounts) where

import Data.List
import Data.Map (Map, fromList)


-- https://exercism.org/tracks/haskell/exercises/rna-transcription
-- [Ether] => Either []
dnaToRna :: Char -> Either Char Char
dnaToRna dna 
  | dna == 'G' = Right 'C'
  | dna == 'C' = Right 'G'
  | dna == 'T' = Right 'A'
  | dna == 'A' = Right 'U'
  | otherwise = Left dna
toRNA :: String -> Either Char String
toRNA = traverse dnaToRna


data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

parseDna dna
  | dna == 'A' = Right A
  | dna == 'C' = Right C
  | dna == 'G' = Right G
  | dna == 'T' = Right T
  | otherwise = Left "error"

-- https://exercism.org/tracks/haskell/exercises/nucleotide-count
nucleotideCounts xs = fmap (fromList . map (\x -> (head x, length x)) . group . sort) (traverse parseDna xs)

-- >>> nucleotideCounts "GATTACA"
-- >>> nucleotideCounts "INVALID"
-- Right (fromList [(A,3),(C,1),(G,1),(T,2)])
-- Left "error"



main :: IO()
main = undefined
