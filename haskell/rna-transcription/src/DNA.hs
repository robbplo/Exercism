module DNA (toRNA) where

toRNA :: String -> Either Char String
toRNA [] = Right []
toRNA (x : xs) = case charToRNA x of
  Left c -> Left c
  Right c -> fmap (c :) (toRNA xs)

charToRNA :: Char -> Either Char Char
charToRNA 'G' = Right 'C'
charToRNA 'C' = Right 'G'
charToRNA 'T' = Right 'A'
charToRNA 'A' = Right 'U'
charToRNA char = Left char
