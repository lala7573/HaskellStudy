module SecretHandshake (handshake) where

-- let words = ["wink", "double blink", "close your eyes", "jump"]
handshake :: Int -> [String]
handshake n
  | length b <= 4 = handshake' words b
  | otherwise = reverse $ handshake' words b
  where
    b = binary n
    words = ["wink", "double blink", "close your eyes", "jump"]

handshake' :: [String] -> [String] -> [String]
handshake' a b
 = map fst $ filter (\(_, b) -> b == "1") (zip a b)
-- >>> handshake 1
-- >>> handshake 2
-- >>> handshake 4

binary :: Int -> [String]
binary n
  | p > 0 = show r:binary p
  | otherwise = [show r]
  where (p, r) = n `divMod` 2

-- >>> binary 1
-- >>> binary 5
-- >>> binary 12
-- [1]
-- [1,0,1]
-- [0,0,1,1]

