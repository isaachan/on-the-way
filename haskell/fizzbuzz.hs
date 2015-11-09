import Data.Char

prog a b c [] = []
prog a b c (x:xs) = (fizzBuzzWhizz a b c x) : prog a b c xs

fizzBuzzWhizz x y z n
  | contains n x = "Fizz"  
  | null mappedWords = (show n)
  | otherwise = mappedWords
  where mappedWords = append (specNumsToWords n [x, y, z] ["Fizz", "Buzz", "Whizz"])

contains num spec = chr (48+spec) `elem` (show num)
append words = foldl (\acc x -> acc ++ x) "" words 
specNumsToWords num specNums words = map (specNumToWord num) (zip specNums words)
specNumToWord num (specNum, word) = if (num `mod` specNum == 0) then word else ""