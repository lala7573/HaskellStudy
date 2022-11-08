---
uuid: 202211071705
tags: Haskell
link: https://wikidocs.net/1568
aliases: 
  - wikibooks_1_4_03alternative와_monadPlus 
---

# 3 Alternative와 MonadPlus
## Alternative 클래스
- Alternative 클래스와 그 메서드들은 Control.Applicative 모듈에서 볼 수 있다.

  ```
  class Applicative f => Alternative f where
    empty :: f a 
    (<|>) :: f a -> f a -> f a
  ```
  - emtpy는 결과가 0개인 applicative computation이고 <|>는 두 computation을 결합하는 이항 함수다
- 예제: 병렬 파싱
  ```
  digit i (c:_)
    | i > 9 || i < 0 = Nothing
    | otherwise      =
      if [c] == show i then Just i else Nothing
  binChar :: String -> Maybe Int
  binChar s = digit 0 s <|> digit 1 s
  ```

## MonadPlus
- MonadPlus 클래스는 Alternative와 밀접한 연관이 있다
  - 메서드 이름들이 다르고, Alternative제약이 Monad로 바뀐 것 
  - mzero == empty, mplus == <|>
```
class Monad m => MonadPlus m where
  mzero :: m a
  mplus :: m a -> m a -> m a`
```
- MonadPlus 클래스가 존재하는 이유 중 하나는 역사적인 것임

## Alternative와 MonadPlus 법칙
- Alternative 에서 가장 흔하게 채택되고 또한 직관을 얻는데 가장 중요한 법칙은, empty와 <|> 가 모노이드를 형성한다는 것이다
  - 모노이드를 형성한다는 것
    - 항등원(nuetral element)와 결합(associative)은 정수 덧셈이 결합법칙을 만족하고, 그 항동원이 0이라고 말하는 것과 같다.
```
  -- empty is a neutral element
  empty <|> u  =  u
  u <|> empty  =  u
  -- (<|>) is associative
  u <|> (v <|> w)  =  (u <|> v) <|> w
  ```
- MonadPlus
  ```
  mzero `mplus` m  =  m
  m `mplus` mzero  =  m
  m `mplus` (n `mplus` o)  =  (m `mplus` n) `mplus` o
  ```
  - 추가적인 법칙 2개가 있다
  ```
  mzero >>= f  =  mzero -- left zero
  m >> mzero   =  mzero -- right zero
  ```

## 유용한 함수들
- asum
  - alternative 값들의 리스트, 가령 [Maybe a]나 [[a]] 를 받아서 <|> 로 결합하는 일이 흔하다
  ```
  asum :: (Alternative f, Foldable t) => t (f a) -> f a
  asum = foldr (<|>) empty
  ```
  - concat의 연산을 일반화 한다. 리스트의 경우 완벽히 동치
  - msum 은 MonadPlus에 특화된 asum
  ```
  msum :: (MonadPlus m, Foldable t) => t (m a) -> m a
  ```
- guard
  ```
  guard :: Alternative m => Bool -> m ()
  guard True  = pure ()
  guard _ = empty
  ```
  - guard는 술어가 False이면 do 블록을 empty로 환원한다.
    - left zero 법칙에 따르면
  ```
  mzero >>= f = mzero
  -- Or, equivalently:
  empty >>= f = empty
  ```
  
## 모노이드와의 관계
- Monoid
  ```
  class Monoid m where 
  mempty  :: m
  mappend :: m -> m -> m
  ```
- Alternative 및 MonadPlus와 수상할 정도로 닮았지만 중요한 차이점이 있다. 인스턴스 선언에서 [] 대신 [a]을 사용한 것에 주목하자. 모노이드는 무언가의 "래퍼"이거나 매개변수 다형성을 가질 필요가 없다. 
  ```
  instance Monoid [a] where
    mempty  = []
    mappend = (++)
  ```