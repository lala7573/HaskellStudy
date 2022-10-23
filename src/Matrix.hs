module Matrix (saddlePoints) where

import Data.Array (Array, assocs)

saddlePoints :: Array (Int, Int) Int -> [(Int, Int)]
saddlePoints matrix = [(x,y) 
  | ((x,y),z) <- assocs matrix, 
    all (z>=) [z' | ((x',_),z') <- assocs matrix, x' == x] &&
    all (z<=) [z' | ((_,y'),z') <- assocs matrix, y' == y]                         
  ]
