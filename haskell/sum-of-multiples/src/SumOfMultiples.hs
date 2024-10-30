module SumOfMultiples (sumOfMultiples) where

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = sum multiples
  where
    multiples = [x | x <- [1 .. (limit - 1)], any (isDivisibleBy x) factors]
    isDivisibleBy _ 0 = False
    isDivisibleBy x y = x `mod` y == 0
