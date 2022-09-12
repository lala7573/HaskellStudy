{-|
Module: BaseballGame
Description: Baseball Game

Baseball Game 규칙
- 정답은 서로 겹치는 자릿수가 없는 세자리의 숫자 (123, 549, 608 등) 
- 플레이어는 정답이 뭔지 추측해야함
- 정답과 플레이어가 낸 답을 비교해서 각 자릿수에 대해 숫자와 위치가 모두 일치할 경우 Strike, 숫자만 일치할 경우 Ball
  ex - 정답이 123일 때 124는 2S 0B, 231은 0S 3B
- 정답을 맞추면 게임이 끝남
-}
module Main (main) where

import Data.List
import System.Random
import Control.Monad

-- | 정답 생성
makeAnswer :: StdGen -> Int
makeAnswer gen = head candidates
  where rands = randomRs (0, 9) gen
        candidates = do
            h <- rands
            guard (h /= 0)
            t <- rands
            guard (h /= t)
            o <- rands
            guard (o /= t && o /= h)
            return (h * 100 + t * 10 + o)

getInput :: String -> Maybe Int
getInput raw = go (reads raw)
  where go [] = Nothing
        go [(i, [])]
          | i == 0 = Just 0
          | i > 999 || i < 100 = Nothing
          | (length . nub . show) i == 3 = Just i
          | otherwise = Nothing
        go _ = Nothing

end :: IO()
end = do
  putStrLn "game over."

retry :: Int -> IO()
retry answer = do
  putStrLn "invalid input."

check :: Int -> Int -> IO()
check answer guess
  | answer == guess = do
      putStrLn "you are right!"
      end
  | otherwise = do
      let (s, b) = getStrikeAndBall answer guess
      putStrLn $ show s ++ " strike, " ++ show b ++ " ball"
      play answer

getStrikeAndBall :: Int -> Int -> (Int, Int)
getStrikeAndBall answer guess = (strike, ball)
  where a = show answer
        g = show guess
        strike = length $ filter (\(x, y) -> x == y) (zip a g)
        ball = length (filter (\x -> x `elem` a) g) - strike

play :: Int -> IO()
play answer = do
  putStrLn  "guess the answer!(0: exit)"
  rawInput <- getLine
  let input = getInput rawInput
  case input of Just 0 -> end
                Nothing -> retry answer
                Just guess -> check answer guess
main:: IO()
main = do
  gen <- getStdGen
  play $ makeAnswer gen
  