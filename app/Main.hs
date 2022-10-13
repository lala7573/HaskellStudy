module Main (main) where

-- anagram은 새로운 단어를 형성하기위해 문자를 재배열하는 것
import Data.Char (toLower)
import Data.List (sort)

-- >>> sort "listen"
-- "eilnst"
-- >>> sort "listen" == sort "google"
-- False

arrange :: String -> [Char]
arrange = sort . map toLower

anagramsFor :: String -> [String] -> [String]
anagramsFor xs xss = [x | x <- xss, target == arrange x && lower /= map toLower x]
  where 
    target = arrange xs
    lower = map toLower xs

test xs xss = [x | x <- xss, xs == x]
-- >>> test "listen" ["listen", "apple"]
-- ["listen"]

-- >>> anagramsFor "Orchestra" ["cashregister", "Carthorse", "radishes"]
-- ["Carthorse"]

main :: IO()
main = undefined
