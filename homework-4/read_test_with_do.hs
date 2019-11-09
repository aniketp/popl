{-
 - Homework 4 :: CS350A 2019-20 I
 - Author: Aniket Pandey (160113)
 -}

----------------------------------------------------
----------------- Problem 2.4 (a) ------------------
----------------------------------------------------
main = do
    stuff <- readFile "test.txt"
    print . length . words $ stuff
