module Queens (boardString, canAttack) where

import Data.List (intersperse)

boardString :: Maybe (Int, Int) -> Maybe (Int, Int) -> String
boardString white black = unlines $ map line [0 .. 7]
  where
    line row = intersperse ' ' $ reverse $ boardLine white black row 7

boardLine :: Maybe (Int, Int) -> Maybe (Int, Int) -> Int -> Int -> String
boardLine _ _ _ (-1) = []
boardLine w b row col = square : boardLine w b row (col - 1)
  where
    square
      | Just (row, col) == w = 'W'
      | Just (row, col) == b = 'B'
      | otherwise = '_'

canAttack :: (Int, Int) -> (Int, Int) -> Bool
canAttack (xa, ya) (xb, yb)
  | xa == xb || ya == yb = True
  | (xa - yb) == (ya - yb) = True
  | otherwise = False
