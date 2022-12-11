module RunLength (decode, encode) where

import Data.Char
import Data.List (group)

decode :: String -> String
decode [] = ""
decode [c] = [c]
decode xs
  | num' == "" = h:decode t
  | otherwise = replicate num h ++ decode t
  where
    (num', next) = span isDigit xs
    num = read num'
    h = head next
    t = tail next

-- >>> span isDigit "2h"
-- ("2","h")

-- >>> decode "X2YZ"
-- >>> decode "2 hs"
-- "XYYZ"
-- Prelude.read: no parse

countChar xs
  | len == 0 || len == 1 = ""
  | otherwise = show len

  where len = length xs
encode :: String -> String
encode text = concatMap ((++) <$> countChar <*> (: []) . head) (group text)

-- >>> encode "XYZ"
-- >>> encode "  hsqq qww  "
-- "XYZ"
-- "2 hs2q q2w2 "
