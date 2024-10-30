module Prime (nth) where

nth :: Int -> Maybe Integer
nth 0 = Nothing
nth n = Just (sieve [2 ..] !! (n - 1))
  where
    sieve (p : xs) = p : sieve [x | x <- xs, x `mod` p > 0]
