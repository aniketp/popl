main = readFile "test.txt" >>= print . length . words
