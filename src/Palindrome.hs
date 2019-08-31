module Palindrome
    ( TknType (..)
    , Token (..)
    , Source (..)
    , find
    , findInList
    , sortPDesc
    , sortPAsc
    , extractPalindrome
    , plen
    ) where

import Prelude hiding (length)
import Data.Vector (Vector, fromList, (!), length) 
import Data.List (sortOn)
import Data.Maybe (mapMaybe)
import Debug.Trace

data TknType = First | Middle | Last | Single
    deriving (Eq, Show)

data Token a = Tkn { el :: a
                   , spos :: Int
                   , epos :: Int
                   , tp :: TknType
                   } deriving (Show)

type Source a = Vector (Token a)

data Palindrome a = Even (Source a) Int Int | Odd (Source a) Int Int deriving Show

getV :: Palindrome a -> Source a
getV (Even v _ _) = v
getV (Odd v _ _) = v

getX :: Palindrome a -> Int
getX (Even _ x _) = x
getX (Odd _ x _) = x

getY :: Palindrome a -> Int
getY (Even _ _ y) = y
getY (Odd _ _ y) = y

findInList :: (Eq a) => [Token a] -> [Palindrome a]
findInList = find . fromList

find :: (Eq a) => Source a -> [Palindrome a]
find = processSimples . findSimples

findSimples :: (Eq a) => Source a -> [Palindrome a]
findSimples v = foldr (\x ps -> go x ++ ps) [] [1..length v - 1]
    where go x = [Even v (x - 1) (x - 1) | x > 0 && checkE x] ++
                 [Odd v (x - 2) (x - 1) | x > 1 && checkO x]
          checkE x = el (v ! (x - 1)) == el (v ! x)
          checkO x = el (v ! (x - 2)) == el (v ! x)

processSimples :: (Eq a) => [Palindrome a] -> [Palindrome a]
processSimples = mapMaybe (shrink . extend)

extend :: (Eq a) => Palindrome a -> Palindrome a
extend p
    | x <= 0 = p
    | (x + plen p) >= length v = p
    | el (v ! (x - 1)) == el (v ! (x + plen p)) = extend . extend' $ p
    | otherwise = p
    where x = getX p
          y = getY p
          v = getV p
          extend' (Even v x y) = Even v (x - 1) y
          extend' (Odd v x y) = Odd v (x - 1) y

shrink :: Palindrome a -> Maybe (Palindrome a)
shrink p
    | getX p >= getY p = Nothing
    | (tfst == First || tfst == Single) && (tlst == Last || tlst == Single) = Just p
    | otherwise = shrink . shrink' $ p
    where tfst = tp (getV p ! getX p)
          tlst = tp (getV p ! (getX p + plen p - 1))
          shrink' (Even v x y) = Even v (x + 1) y
          shrink' (Odd v x y) = Odd v (x + 1) y

sortPDesc :: [Palindrome a] -> [Palindrome a]
sortPDesc = sortOn ((* (-1)) . plen)

sortPAsc :: [Palindrome a] -> [Palindrome a]
sortPAsc = sortOn plen

plen :: Palindrome a -> Int
plen (Even _ x y) = (y - x + 1) * 2
plen (Odd _ x y) = (y - x) * 2 + 1

extractPalindrome :: Palindrome a -> [b] -> [b]
extractPalindrome p = take (lst - fst + 1) . drop fst
    where fst = spos (getV p ! getX p)
          lst = epos (getV p ! (getX p + plen p - 1))
