import Data.List (foldl')

timeToDist :: [(Int, Int)]
-- timeToDist = [(55, 401), (99, 1485), (97, 2274), (93, 1405)]
timeToDist = [(55999793, 401148522741405)]

waysToBeat :: Int -> Int -> [Int]
waysToBeat time dist
  | i * (time - i) > dist = [time - (2 * i) + 1]
  | otherwise = []
  where
    i = head [x | x <- [0..(time-1)], x * (time - x) > dist]

main :: IO ()
main = do
  let waysToBeatList = foldl' (\acc (time, dist) -> acc ++ waysToBeat time dist) [] timeToDist
  let result = foldl' (*) 1 waysToBeatList
  print result
