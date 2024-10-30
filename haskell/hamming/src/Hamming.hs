module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance [] (_ : _) = Nothing
distance (_ : _) [] = Nothing
distance [] [] = Just 0
distance (x : xs) (y : ys) = fmap increment (distance xs ys)
  where
    increment = if x == y then id else (+ 1)
