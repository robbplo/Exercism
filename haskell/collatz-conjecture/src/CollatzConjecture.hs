module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz n
  | n < 1 = Nothing
  | otherwise = Just $ step n 0

step :: Integer -> Integer -> Integer
step n i
  | n == 1 = i
  | even n = step (n `div` 2) (i + 1)
  | otherwise = step ((3 * n) + 1) (i + 1)
