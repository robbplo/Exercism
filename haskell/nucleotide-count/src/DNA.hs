module DNA (nucleotideCounts, Nucleotide (..)) where

import qualified Data.Map as Map

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map.Map Nucleotide Int)
nucleotideCounts [] = Right $ Map.fromList [(A, 0), (C, 0), (G, 0), (T, 0)]
nucleotideCounts ('A' : xs) = fmap (Map.adjust (+ 1) A) (nucleotideCounts xs)
nucleotideCounts ('C' : xs) = fmap (Map.adjust (+ 1) C) (nucleotideCounts xs)
nucleotideCounts ('G' : xs) = fmap (Map.adjust (+ 1) G) (nucleotideCounts xs)
nucleotideCounts ('T' : xs) = fmap (Map.adjust (+ 1) T) (nucleotideCounts xs)
nucleotideCounts (_ : xs) = Left xs
