module Main where

import System.IO
import Control.Monad
import Data.List
import Data.Char
import Palindrome

tokenize :: String -> [Token Char]
tokenize = go 0 Last
    where go _ _ [] = []
          go x tt [c]
              | isAlphaNum c && tt == Middle = [Tkn (toUpper c) x x Last]
              | isAlphaNum c = [Tkn (toUpper c) x x Single]
              | otherwise = []
          go x tt (c:c':cs)
              | isAlphaNum c = Tkn (toUpper c) x x tt' : go (x + 1) tt' (c':cs)
              | otherwise = go (x + 1) Last (c':cs)
              where tt' | tt == Last && not (isAlphaNum c' || c' == '’') = Single
                        | tt == Last = First
                        | isAlphaNum c' = Middle
                        | otherwise = Last

main :: IO ()
main = do
    fn <- getLine
    cs <- readFile fn
    putStrLn $ intercalate "\n------------\n" . map (`extractPalindrome` cs) $
          (filter (\p -> plen p > 5) . sortPDesc . findInList . tokenize $ cs)
