---
uuid: 202210272359
tags: haskell
link: https://wikidocs.net/150827
aliases: 
  - wikibooks_4_모나드 
---

# wikibooks_4_모나드
## Applicative
```

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
  sx <- getLine
  sy <- getLine
  let mx = readMaybe sx :: Maybe Double -- type annotation
      my = readMaybe sy :: Maybe Double
  case (+) <$> mx <*> my of
    Just z -> putStrLn ("The sum of your numbers is " ++ show z)
    Nothing -> do
        putStrLn "Invalid number. Retrying..."
        interactiveSumming
```

## IO

```
getLine :: IO String
```
하스켈의 핵심 기능은 우리가 작성할 수 있는 모든 표현식은 참조 투명(referentially transparent)하다는 것이다.
이는 프로그램의 동작을 변경하지 않으면서 어떤 표현식이든 그것의 값으로 대체할 수 있음을 뜻한다.

```

addExclamation :: String -> String
addExclamation s = s ++ "!"

main = putStrLn . addExclamation <$> getLine


interactiveSumming = do
  putStrLn "Choose two numbers:"
  mx <- readMaybe <$> getLine
  my <- readMaybe <$> getLine
  case (+) <$> mx <*> my :: Maybe Double of
    Just z -> putStrLn ("The sum of your numbers is " ++ show z)
    Nothing -> do
        putStrLn "Invalid number. Retrying..."
        interactiveSumming

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

```

## 핵심 요약
- `Applicative`는 적용성 펑터를 위한 `Functor`의 서브 클래스로서, 펑터를 떠나지 않고 함수 적용을 할 수 있게 해주느 펑터다
- `Applicative`의 `<*>` 메서드는 다중 인자를 위한 `fmap`일반화로서 사용할 수 있다.
- `IO a`는 `a` 타입의 실재하는 값이 아니라 프로그램이 실행될 때 실현될 `a`값의 자리표이자 이 값이 어떤 수단을 통해 전달될 것이라는 약속이다. 이로써 I/O액션을 다룰 때도 참조 투평성을 만족하게 된다.
- `IO`는 펑터이고 특히 `Applicative`의 인스턴스로서, I/O 액션에 의해 생산된 값을 그 비결정성에도 불구하고 조작할 수 있는 수단을 제공한다
- functorial 값은 어떤 문맥 안의 값들로 이루어졌다고 볼 수 있다. `<$>` 연산자 (즉 `fmap`)은 그 문맥을 통과해서 기저의 값을 수정한다. `<*>`연산자는 두 functorial 값의 문맥들과 기저 값들을 합성한다
- `IO`의 경우 `<*>`와 `(*>)`는 I/O 액션들을 연결함으로써 문맥들을 합성한다
- `do`블록의 역할은 단지 `(*>)`의 편의 문법을 제공하는 것이 많은 부분을 차지한다 ???

