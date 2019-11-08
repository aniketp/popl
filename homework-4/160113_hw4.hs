{-
 - Homework 4 :: CS350A 2019-20 I
 - Author: Aniket Pandey (160113)
 -}

permute :: (Num a) => [a] -> [b] -> [a]
permute _ _ = []
permute (x:xs) (y:ys) =  

------------------------------------------------------------
--------------------- Problem 1.2 --------------------------
------------------------------------------------------------
compose :: [(a -> a)] -> a -> a
compose [] x = x
compose (x:xs) y = compose xs (x y)

------------------------------------------------------------
--------------------- Problem 1.3 --------------------------
------------------------------------------------------------
altMap :: [a] -> (a -> b) -> (a -> b) -> [b]
altMap (fst:snd:rest) f g = (f fst):(g snd): altMap rest f g
altMap [x] f g = [f x]
altMap _ _ _ = []

------------------------------------------------------------
--------------------- Problem 2.1 --------------------------
------------------------------------------------------------
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

------------------------------------------------------------
--------------------- Problem 2.2 --------------------------
------------------------------------------------------------
occurs :: Ord a => a -> BinaryTree a -> Bool
occurs key Nil = False
occurs key (Node x left right)
    | key == x = True
    | key < x = (occurs key left)
    | key > x = (occurs key right)

------------------------------------------------------------
--------------------- Problem 2.3 --------------------------
------------------------------------------------------------
printEdges :: (Show a) => (a, a) -> String
printEdges x = "  " ++ (show (fst x)) ++ " -> " ++ (show (snd x)) ++ ";"

digraph :: (Show a) => [(a, a)] -> IO ()
digraph x = do
    putStrLn "digraph {"
    mapM_ (\x -> putStrLn x) $ fmap printEdges x
    putStrLn "}"

------------------------------------------------------------
--------------------- Problem 2.5 --------------------------
------------------------------------------------------------

-- Given functions:
safeFirst lst 
    | (length lst)==0 = error "Empty List" 
    | otherwise       = head lst

safeReciprocal x
    | x==0 = error "Undefined"
    | otherwise = 1/x

-- Here, the error function takes a string and returns a type
-- suitable for a particular case. The implementation of error
-- in GHC/Err.hs
--
-- error :: [Char] -> a
-- error s = raise# (errorCallException s)
--
-- The returned type "a" is then cast into the type required by
-- the function into consideration. e.g [a]->a, a -> Fractional a
