import Data.List
import Text.Regex.Posix
import Data.Function
import Data.Maybe

solve :: String -> String -> [(String, [String])] -> Int
solve pos end graph = fromJust $ findIndex (\i -> (follow pos dirs !! (i `mod` length dirs)) `endsWith` end) [0..1000000]
  where
    dirs = snd $ head graph
    follow p dirs' = fromJust $ fmap (!! (if dirs' == "R" then 1 else 0)) (lookup p graph)
    endsWith str suffix = suffix `isSuffixOf` str

main :: IO ()
main = do
  contents <- readFile "data.txt"
  let (dirs:graphLines) = lines contents
      graph = map (\s -> let (start:endings) = getAllTextMatches (s =~ "\\w+") :: [String] in (start, endings)) graphLines

  putStrLn $ show $ solve "AAA" "ZZZ" graph
  putStrLn $ show $ foldl lcm 1 [solve s "Z" graph | (s, _) <- filter (\(s, _) -> "A" `isSuffixOf` s) graph]
