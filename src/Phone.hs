module Phone (number) where

type Digit = Char
data NANPElement =
  CountryCode [Digit]
  | AreaCode [Digit]
  | ExchangeCode [Digit]
  | SubscriberNumber [Digit]

instance Show NANPElement where
  show value = case value of
    CountryCode a -> a
    AreaCode a -> a
    ExchangeCode a -> a
    SubscriberNumber a -> a

-- >>> show $ AreaCode "123"
-- "123"

isN = flip elem ['2'..'9']

getNumber = filter $ flip elem ['0'..'9']

chunk [] [] = []
chunk xs [] = [xs]
chunk xs (n:ns) = take n xs:chunk (drop n xs) ns

printNANP :: [NANPElement] -> String
printNANP (x:xs) = case x of
  CountryCode _ -> printNANP xs
  _ -> show x ++ printNANP xs
printNANP _ = ""
-- number :: String -> Maybe String
-- number :: [Digit] -> Maybe String
number xs = printNANP <$> number' (getNumber xs)
number' nums
  | len == 11 = mkNANP $ chunk nums [1, 3, 3, 4]
  | len == 10 = mkNANP $ chunk nums [0, 3, 3, 4]
  | otherwise = Nothing
  where len = length nums
-- number' :: [[Digit]] -> Maybe [NANPElement]
mkNANP [c, a, e, s] =
    sequence [
    CountryCode <$> handleCountryCode c,
    AreaCode <$> handleAreaCode a,
    ExchangeCode <$> handleExchangeCode e,
    SubscriberNumber <$> handleSubscriberNumber s]
mkNANP _ = Nothing

handleCountryCode :: [Digit] -> Maybe [Digit]
handleCountryCode [] = Just []
handleCountryCode (x:xs)
  | x == '1' = Just ['1']
  | otherwise = Nothing

handleAreaCode :: [Digit] -> Maybe [Digit]
handleAreaCode xs
  | length xs /= 3 = Nothing
  | isN $ head xs = Just xs
  | otherwise = Nothing

handleExchangeCode :: [Digit] -> Maybe [Digit]
handleExchangeCode xs
  | length xs /= 3 = Nothing
  | isN $ head xs = Just xs
  | otherwise = Nothing

handleSubscriberNumber :: [Digit] -> Maybe [Digit]
handleSubscriberNumber xs
  | length xs /= 4 = Nothing
  | otherwise = Just xs


-- >>> length "16139950253"
-- 11

-- >>> number "+1 (613)-995-0253"
-- >>> number "613-995-0253"
-- >>> number "1 613 995 0253"
-- >>> number "+1 (223) 456-7890"
-- Just "16139950253"
-- Just "6139950253"
-- Just "16139950253"
-- Just "6139950253"
