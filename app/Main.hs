module Main (main) where

import Text.Read

-- Applicative <$>, <*>
interactiveDoubling = do
  putStrLn "Choose a number:"
  s <- getLine
  let mx = readMaybe s :: Maybe Double -- type annotation
  case (2*) <$> mx of
    Just x -> putStrLn ("The double of your number is " ++ show x)
    Nothing -> do
            putStrLn "This is not a valid number. Retrying..."
            interactiveDoubling


interactiveSumming = do
  putStrLn "Choose two numbers:"
  mx <- readMaybe <$> getLine
  my <- readMaybe <$> getLine
  case (+) <$> mx <*> my :: Maybe Double of
    Just z -> putStrLn ("The sum of your numbers is " ++ show z)
    Nothing -> do
        putStrLn "Invalid number. Retrying..."
        interactiveSumming
-- (<*>) :: Maybe (a -> b) -> Maybe a -> Maybe b
-- >>> (,) <$> (Just 3) <*> (Just 4)
-- >>> (+) <$> (Just 3) <*> (Just 4)
-- Just (3,4)
-- Just 7

-- instance Applicative Maybe where
--   pure = Just 
--   (Just f) <*> (Just x) = Just (f x)
--   _        <*> _        = Nohting



addExclamation :: String -> String
addExclamation s = s ++ "!"

main = putStrLn . addExclamation <$> getLine


interactiveConcatenating :: IO()
-- interactiveConcatenating = do
--   putStrLn "Choose two strings:"
--   sx <- getLine
--   sy <- getLine
--   putStrLn "Let's concatenate them:"
--   putStrLn (sx ++ sy)

-- interactiveConcatenating = do
--   putStrLn "Choose two strings:"
--   sz <- (++) <$> getLine <*> getLine
--   putStrLn "Let's concatenate them:"
--   putStrLn sz

-- (<*>)는 액션들의 순서를 존중하므로 그 액션들을 나열하는 수단도 제공한다. 
-- u *> v = (\_ y -> y) <$> u <*> v
-- (\_ y -> y) <$> putStrLn "First!" <*> putStrLn "Second!"
-- putStrLn "First!" *> putStrLn "Second!"

interactiveConcatenating = do
  sz <- putStrLn "Choose two strings:" *> ((++) <$> getLine <*> getLine)
  putStrLn "Let's concatenate them:" *> putStrLn sz
