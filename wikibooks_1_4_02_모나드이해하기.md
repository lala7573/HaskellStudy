---
uuid: 202210282124
tags: haskell monad
link: https://wikidocs.net/1471
aliases: 
  - wikibooks_1_4_02_모나드이해하기 
---

# wikibooks_1_4_02_모나드이해하기
역사적으로 모나드는 하스켈에서 입출력을 수행하기 위해 도입되었다. 
모나드는 예외, 상태, 비결정성 non-determinism, 연속성 continuation, 코루틴, 그 외에 수많은 것을 지원한다.

- 모나드는 세 가지에 의해 정의된다
  - 타입 생성자 M
  - return 함수
  - "bind"라 부르는 (>>=) 연산자
```
return :: a -> M a
(>>=)  :: M a -> ( a -> M b ) -> M b
```
- Maybe
```
return :: a -> Maybe a
return x  = Just x

(>>=)  :: Maybe a -> (a -> Maybe b) -> Maybe b
m >>= g = case m of
             Nothing -> Nothing
             Just x  -> g x
```

하스켈에서는 `Monad` 타입 클래스를 이용해 모나드를 구현한다.
```
class Monad m where
    return :: a -> m a
    (>>=)  :: m a -> (a -> m b) -> m b

    (>>)   :: m a -> m b -> m b -- "then"
    fail   :: String -> m a
```

제약이 Applicative 에서 Monad로 바뀐 것 뿐이지, 각 메서드는 서로 교체할 수 있다.
`(*>)` = `(>>)`, `pure` = `return`

명령형 언어의 여러 의미(semantic)는 각기 다른 모나드에 대응한다.


| 모나드 | 명령형 언어에서의 의미 semantic | 위키책 과목 |
|------ |---------------------------|--------- |
| Maybe | 예외(익명) | 모나드 이해하기/Maybe |
| Error | 예외(오류 내용이 있음) | 모나드 이해하기/Error |
| State | 전역 상태global state | 모나드 이해하기/State |
| IO | 입출력 | 모나드 이해하기/IO |
| [](리스트) | 비결정성 | 모나드 이해하기/List |
| Reader | 환경설정Environment | 모나드 이해하기/Reader |
| Writer | 로거Logger | 모나드 이해하기/Writer |

- 모나드 transformer를 사용해서 모나드들을 합성하고, 일치시키거나 여러 모나드의 semantic을 단일 모나드로 합성하는 것이 가능하다

- 모나드의 법칙
  - 하스켈에서 Monad 타입 클래스의 모든 인스턴스는 (그리고 (>>=)와 return의 모든 구현은) 다음 세 법칙을 만족해야 한다.
  ```
  m >>= return     =   m                        -- 우단위원의 법칙 (right unit)
  return x >>= f   =   f x                      -- 좌단위원의 법칙 (left unit)

  (m >>= f) >>= g  =   m >>= (\x -> f x >>= g ) -- 결합법칙(associativity)
  ```
  - 중립원 neutral element 으로서의 return
    - return 의 동작은 left unit의 법칙과 right unit의 법칙에 의해 기술 된다.
    - return은 값을 보관한다. (아무 계산도 하지 않음)
  - bind의 결합 법칙
    - bind 연산자(>>=)가 계산의 순서만 신경쓸 뿐 그 중첩 구조는 고려하지 않음을 보장한다
    - then 연산자의 결합법칙은 특수한 경우다.
    ```
    (m >> n) >> o = m >> (n >> o)
    ```
  - 모나딕 합성
    ```
    (f >=> g) >=> h   =   f >=> (g >=> h)
    ```
    - `(>=>)` 정의
    ```
    (>=>) :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c
    f >=> g = \x -> f x >>= g
    ```
    - `(>=>)`는 모나딕 합성 연산자로서 함수 합성 연산자 `(.)`와 아주 유사하지만 그 인자는 반대로다.
    - `(<=<)`는 `(.)`와 합성 순서가 일치한다.
- 모나드와 범주론
  ```
  fmap   :: (a -> b) -> M a -> M b  -- functor
  return :: a -> M a
  join   :: M (M a) -> M a
  ```
  - `fmap`은 주어진 함수를 컨테이너 내부의 모든 원소에 적용한다
  - `return`은 원소를 컨테이너로 감싼다
  - `join`은 컨테이너의 컨테이너를 취해 단일 컨테이너로 평탄화한다.

  ```
  m >>= g = join (fmap g m)
  fmap f x = x >>= (return . f)
  join x = x >>= id
  ```
- `liftM`과 그 친구들
  - liftM은 fmap 과 바꿔 쓸 수 있다.
  ```
  liftM :: (Monad m) => (a1 -> r) -> m a1 -> m r
  ```
  - ap는 <*>의 모나드 전용 버전이다
  ```
  ap :: Monad m => m (a -> b) -> m a -> m b
  ```

## Maybe
Maybe 모나드는 값을 반환하지 않음으로써 "잘못될 수 있는" 계산(computation)을 표현한다. 참고를 위해 여기 앞의 장에서 봤던 Maybe용 return과 (>>=)의 정의가 있다.1
```
return :: a -> Maybe a
return x  = Just x

(>>=)  :: Maybe a -> (a -> Maybe b) -> Maybe b
(>>=) m g = case m of
               Nothing -> Nothing
               Just x  -> g x
```
기술적으로 말하자면 Maybe 모나드의 구조는 실패를 확산시킨다.

## List
모나드로서의 리스트는 임의 개수의 결과를 반환하는 비결정적 연산을 모델링한다.
리스트 모나드가 비결정성을 나타낸다고 말하는 이유는, 서로 다른 함수들을 리스트에 매핑하면 임의 개수의 서로 다른 결과들을 반환하기 때문이다.
```
xs >>= f = concat (map f xs)
concatMap f xs = concat (map f xs)) 
```
- concatMap은 리스트에 대한 >>=와 같다

## do 표기
- do 표기에서는 관련된 모나드의 fail 메서드가 실패를 처리
  - 가령 Maybe의 fail은 fail _ = Nothing이고, 비슷하게 리스트 모나드의 경우 fail _ = []이다
  - do 표기
```
nameDo :: IO ()
nameDo = do putStr "What is your first name? "
            first <- getLine
            putStr "And your last name? "
            last <- getLine
            let full = first ++ " " ++ last
            putStrLn ("Pleased to meet you, " ++ full ++ "!")
```
  - bind표기
```
nameLambda :: IO ()
nameLambda = putStr "What is your first name? " >>
             getLine >>= \ first ->
             putStr "And your last name? " >>
             getLine >>= \ last ->
             let full = first ++ " " ++ last
             in putStrLn ("Pleased to meet you, " ++ full ++ "!")
```
## IO
- IO 모나드는 액션을 하스켈 값으로 표현하여, 순수 함수를 통해 그 값을 조작하기 위한 수단이다.
```
module Main where

import Data.Char (toUpper)
import Control.Monad

main = putStrLn "Write your string: " >> liftM shout getLine >>= putStrLn

shout = map toUpper
```
- do 표기
```
do putStrLn "Write your string: "
   string <- getLine
   putStrLn (shout string)
```
- 순수와 비순수
```
speakTo :: (String -> String) -> IO String
speakTo fSentence = liftM fSentence getLine

-- 용례.
sayHello :: IO String
sayHello = speakTo (\name -> "Hello, " ++ name ++ "!")
```
  - 하스켈 표현식은 항상 참조투명성(referential transparency)을 가진다.
- 하스켈이 순수 함수형 언어지만 IO 액션은 비순수하다고 말할 수 있는 이유는 IO 액션이 외부에 끼치는 영향이, (하스켈 내부에 완전히 포함되는 정규 효과와 반대로) 부수 효과이기 때문이다. 
  - 순수 함수형 언어는 비순수 값을 포함한 표현식조차 참조 투명성을 보장한다. 
  - 이것이 뜻하는 바는 비순수를 표현하고 추론하고 처리하는 것이 순수 함수형 방식으로 가능하다는 것이다. 
  - functor나 모나드 같은 순수 함수형 장치를 통해서 말이다.
  - IO 액션은 비순수하지만 그 액션을 조작하는 모든 하스켈 함수는 순수하다.
- 함수형의 순수함을 입출력 타입과 결합하면 하스켈 프로그래머에게 여러모로 이익이 된다. 
  - 참조투명성이 보장되기에 컴파일러 최적화의 여지가 많아진다. 
  - 타입만으로는 IO 값들을 분간할 수 없어서 어디가 부수 효과나 불투명한 값인지 한 눈에 파악할 수 있다. 
  - IO 자체가 또다른 functor일 뿐이기 때문에 예측 가능한 영역을 최대로 유지하고 순수 함수와 연게되는 추론을 쉽게 만든다.
- `sequence $ replicate 5 getLine` = `replicateM 6 getLine`
- `mapM`, `mapM_`, `forM`, `formM_`
  ```
  mapM :: (Monad m) => (a -> m b) -> [a] -> m [b]
  mapM_ :: (Monad m) => (a -> m b) -> [a] -> m ()
  ```
## State
- 이 장에서는 transformers 패키지의 Control.Monad.Trans.State 모듈이 제공하는 상태 모나드를 사용할 것이다. 실전에서 하스켈 코드를 읽다보면 mtl 패키지와 밀접한 관련이 있는 Control.Monad.State 모듈을 보게 될 것
- newtype은 생성자가 하나고 필드도 하나인 타입에만 쓸 수 있다. newtype은 자명한 단일 필드의 래핑와 언래핑이 컴파일러에 의해 제거됨을 보장한다. 이 때문에 State 같은 단순한 래퍼는 newtype으로 정의되곤 한다. 그럼 type으로 별칭을 정의해도 충분하지 않을까? type은 새로운 데이터 타입에 대한 인스턴스 정의를 허용하지 않기 때문에 그럴 수 없다.

나중에 필요할 때 다시 보자!ㅎㅎ