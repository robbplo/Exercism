module LinkedList
  ( LinkedList,
    datum,
    fromList,
    isNil,
    new,
    next,
    nil,
    reverseLinkedList,
    toList,
  )
where

import Data.List (unfoldr)

data LinkedList a = Dummy | Node a (LinkedList a) deriving (Eq, Show)

datum :: LinkedList a -> a
datum (Node val _) = val
datum Dummy = error "datum of nil node"

fromList :: [a] -> LinkedList a
fromList = foldr new nil

isNil :: LinkedList a -> Bool
isNil Dummy = True
isNil _ = False

new :: a -> LinkedList a -> LinkedList a
new x Dummy = Node x Dummy
new x nxt = Node x nxt

next :: LinkedList a -> LinkedList a
next Dummy = nil
next (Node _ nxt) = nxt

nil :: LinkedList a
nil = Dummy

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList = fromList . reverse . toList

toList :: LinkedList a -> [a]
toList = unfoldr next'
  where
    next' Dummy = Nothing
    next' (Node val nxt) = Just (val, nxt)
