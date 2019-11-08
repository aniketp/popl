{-
 - Homework 4 :: CS350A 2019-20 I
 - Author: Aniket Pandey (160113)
 -}

{-permute :: (Num a) => [a] -> [b] -> [a]-}
{-permute _ _ = []-}
{-permute (x:xs) (y:ys) =  -}

compose :: [(a -> a)] -> a -> a
compose [] x = x
compose (x:xs) y = compose xs (x y)

altMap :: [a] -> (a -> b) -> (a -> b) -> [b]
altMap (fst:snd:rest) f g = (f fst):(g snd): altMap rest f g
altMap [x] f g = [f x]
altMap _ _ _ = []

data BinaryTree a = Nil | Node a (BinaryTree a) (BinaryTree a)
                        deriving (Eq, Show, Read)

binaryTreeMap :: (a -> b) -> BinaryTree a -> BinaryTree b
binaryTreeMap f Nil = Nil
binaryTreeMap f (Node a left right) = Node (f a) (binaryTreeMap f left) (binaryTreeMap f right)

instance Functor BinaryTree where
    fmap = binaryTreeMap

instance Applicative BinaryTree where
    pure x = Node x Nil Nil
    Nil <*> _ = Nil
    _ <*> Nil = Nil
    Node f left right <*> Node x left' right' = Node (f x) (left <*> left') (right <*> right')

instance Monad BinaryTree where
    return x = Node x Nil Nil
    Nil >>= _ = Nil
    Node x left right >>= f = f x
