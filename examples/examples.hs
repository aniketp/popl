-- Data declarations
type Position = (Float, Float)
data Move = Left' | Right' | Up | Down deriving (Show)

data Motion = Left'' {position :: Position}
              | Right'' {position :: Position}
              | Up' {position :: Position}
              | Down' {position :: Position} deriving (Show, Read)

move :: Move -> Position -> Position
move Left' (x, y) = (x-1, y)
move Right' (x, y) = (x+1, y)
move Up (x, y) = (x, y+1)
move Down (x, y) = (x, y-1)

-- data Maybe a = Nothing | Just a
safediv :: Int -> Int -> Maybe Int
safediv 0 _ = Nothing
safediv a b = Just (a `div` b)

safehead :: [a] -> Maybe a
safehead [] = Nothing
safehead xs = Just (head xs)

-- Data definitions can be recursive
data List a = Nil | Cons a (List a) deriving (Show)

-- Class and instance declarations
instance Eq Motion where
    (Up' (x, y)) == (Up' (a, b)) = (x == a) && (y == b)
    (Down' (x, y)) == (Down' (a, b)) = (x == a) && (y == b)

-- The Functor Class
class Functor t where
    fmap :: (a -> b) -> t a -> t b

data BinaryTree a = Nil' | Node a (BinaryTree a) (BinaryTree a)
        deriving (Eq, Show)

binaryTreeMap :: (a -> b) -> BinaryTree a -> BinaryTree b
binaryTreeMap f Nil' = Nil'
binaryTreeMap f (Node a left right) = Node (f a) (binaryTreeMap f left) (binaryTreeMap f right)

instance Main.Functor BinaryTree where
    fmap = binaryTreeMap

instance Applicative [] where
    pure x = [x]
    fs <*> xs = [f x| f <- fs, x <- xs]

