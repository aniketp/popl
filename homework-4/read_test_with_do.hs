import System.IO
import Control.Monad

main = do
    contents <- readFile "test.txt"
    print . length . words $ contents
