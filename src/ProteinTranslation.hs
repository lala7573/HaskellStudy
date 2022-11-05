module ProteinTranslation(proteins) where

import Data.List.Split (chunksOf)

-- proteins :: String -> Maybe [String]
proteins rna = sequence . takeWhile (/= Nothing) <$> map translate $ chunksOf 3 rna

-- >>> proteins "AUGUUUUCUUAAAUG"
-- Just ["Methionine","Phenylalanine","Serine"]

translate codon
  | codon == "AUG" = Just "Methionine"
  | codon == "UUU" || codon == "UUC" = Just "Phenylalanine"
  | codon == "UUA" || codon == "UUG" = Just "Leucine"
  | codon == "UCU" || codon == "UCC" || codon == "UCA" || codon == "UCG" = Just "Serine"
  | codon == "UAU" || codon == "UAC" = Just "Tyrosine"
  | codon == "UGU" || codon == "UGC" = Just "Cysteine"
  | codon == "UGG" = Just"Tryptophan"
  | codon == "UAA" || codon == "UAG" || codon == "UGA" = Nothing
  | otherwise = Nothing
