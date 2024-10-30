module Deque (Deque, mkDeque, pop, push, shift, unshift) where

data Deque a = Deque (Maybe (ListNode a)) (Maybe (ListNode a))

data ListNode a = Node a (Maybe (ListNode a)) (Maybe (ListNode a))

mkDeque :: IO (Deque a)
mkDeque = pure (Deque Nothing Nothing)

pop :: Deque a -> IO (Maybe a)
pop deque = error "You need to implement this function."

push :: Deque a -> a -> IO ()
push deque x = error "You need to implement this function."

unshift :: Deque a -> a -> IO ()
unshift deque x = error "You need to implement this function."

shift :: Deque a -> IO (Maybe a)
shift deque = error "You need to implement this function."
