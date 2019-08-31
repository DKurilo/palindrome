module Main where

import System.IO
import Control.Monad
import Data.List
import Data.Char
import Palindrome

tokenize :: String -> [Token String]
tokenize = go 0 ""
    where go x w []
              | null w = []
              | otherwise = [Tkn (wtu w) x (x + length w - 1) Single]
          go x w (c:cs)
              | isAlphaNum c = go x (c:w) cs
              | null w = go (x + 1) "" cs
              | otherwise = Tkn (wtu w) x ep Single : go (ep + 2) "" cs
              where ep = x + length w - 1

wtu :: String -> String
wtu = map toUpper

main :: IO ()
main = do
    fn <- getLine
    cs <- readFile fn
    putStrLn $ intercalate "\n------------\n" . map (`extractPalindrome` cs) $
          (filter (\p -> plen p > 4) . sortPDesc . findInList . tokenize $ cs)
