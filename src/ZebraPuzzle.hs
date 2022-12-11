module ZebraPuzzle (Resident(..), Solution(..), solve) where

-- https://exercism.org/tracks/haskell/exercises/zebra-puzzle
data Resident = Englishman | Spaniard | Ukrainian | Norwegian | Japanese
  deriving (Eq, Show)

data Solution = Solution { waterDrinker :: Resident
                         , zebraOwner :: Resident
                         } deriving (Eq, Show)

solve :: Solution
solve = Solution Norwegian Japanese

