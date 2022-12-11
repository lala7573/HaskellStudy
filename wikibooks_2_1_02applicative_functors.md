---
uuid: 202210272336
tags: haskell
link: https://wikidocs.net/1756
aliases: 
  - applicative_functors
---

# applicative_functors
적용성 펑터(applicative functor)는 추가적인 성질을 가진 펑터
가장 중요한 것은 펑터 내부의 함수를 적용하는게 가능

## Functor
펑터들(즉 Functor 타입 클래스의 인스턴스들)은 "사상(map)할 수 있는" 구조체다.
```
class Functor f where
  fmap :: (a -> b) -> f a -> f b

instance Functor Maybe where
  fmap f (Just x) = Just (f x)
  fmap _ Nothing  = Nothing
```

## 적용성 펑터
```
class (Functor f) => Applicative f where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b

instance Applicative Maybe where
  pure = Just
  (Just f) <*> (Just x) = Just (f x)
  _        <*> _        = Nothing
```

`pure` 함수는 임의 값을 펑터 내부로 전이 시킨다
`(<*>)`는 펑터 내부의 함수를 펑터의 값에 대한 함수로 변경한다.
이 펑터는 몇가지 법칙을 만족해야 한다.

```
pure id <*> v = v                               - 항등법칙 (Identity)
pure (.) <*> u <*> v <*> w = u <*> (v <*> w)    - 결합법칙 (Composition)
pure f <*> pure x = pure (f x)                  - 동형사상 (Homomorphism)
u <*> pure y = pure ($ y) <*> u                 - 교환법칙 (Interchange)
```

그리고 `Functor` 인스턴스는 다음 법칙을 만족해야 한다.

```
fmap f x = pure f <*> x     -- Fmap
```

## 적용성 펑터 사용하기
```
f :: (a -> b -> c)
fmap :: Functor f => (d -> e) -> f d -> f e
fmap f :: Functor f =>           f a -> f (b -> c) 

fmap2 f a b = f <$> a <*> b
fmap3 f a b c = f <$> a <*> b <*> c
fmap4 f a b c d = f <$> a <*> b <*> c <*> d
```

## 모나드와 적용성 펑터
`Monad` 의 모든 인스턴스는 `Applicative` 의 인스턴스로 만들 수 있다
```
Applicative f => a -> f a
Monad m       => a -> m a
```

```
pure  = return
(<*>) = ap

ap f a = do
  f' <- f
  a' <- a
  return (f' a')
```

## ZipLists
`Applicative`가 삶을 편하게 만들어준다.
`[]`의 `Applicative` 인스턴스는 정의할 수 없다. 이미 정의되어 있기 때문이다.
`fs <*> xs`는 fs의 모든 함수를 취해 xs의 모든 값에 적용한다.

```
newtype ZipList a = ZipList [a]

instance Applicative ZipList where
  (ZipList fs) <*> (ZipList xs) = ZipList (zipWith ($) fs xs)
  pure x                        = ZipList (repeat x)

```