module RunLength (decode, encode) where

import Data.Maybe
import Text.Read

decode :: String -> String
decode encodedText = concat $ decode' encodedText []

decode' :: String -> String -> [String]
decode' [] _ = []
decode' (x : xs) count
  | x `notElem` ['0' .. '9'] =
      let intCount = fromMaybe 1 (readMaybe (reverse count) :: Maybe Int)
       in replicate intCount x : decode' xs []
  | otherwise = decode' xs (x : count)

encode :: String -> String
encode [] = []
encode (x : xs) = concat $ encode' (xs ++ ['*']) 1 x

encode' :: String -> Int -> Char -> [String]
encode' [] _ _ = []
encode' (x : xs) count char
  | x == char = encode' xs (count + 1) char
  | count == 1 = [char] : encode' xs 1 x
  | otherwise = (show count ++ [char]) : encode' xs 1 x
  
