module Clock (addDelta, fromHourMin, toString) where

-- padding 구현이런식으로 하는구만
import Text.Printf (printf)
-- toString (Clock totalMin) = printf "%02d:%02d" h m
--   where
--     (h, m) = totalMin `divMod` 60


data Clock = Clock { hour :: Int, minute :: Int}
  deriving Eq


instance Show Clock where
  show c = padding 2 (hour c) ++ ":" ++ padding 2 (minute c)


padding :: Int -> Int -> [Char]
padding n value = replicate lenPadding '0' ++ strValue
  where
    strValue = show value
    lenPadding = n - length strValue

fromHourMin :: Int -> Int -> Clock
fromHourMin _hour _min = Clock { hour=hour', minute=min' }
  where
    (hourFromMin, min') = _min `divMod` 60
    hour' = (hourFromMin + _hour) `mod` 24


toString :: Clock -> String
toString = show

addDelta :: Int -> Int -> Clock -> Clock
addDelta _hour _min clock = fromHourMin (hour clock + _hour) (minute clock + _min)

