module School (School, add, empty, grade, sorted) where

import Data.List 

data Student = Student { gradeNum:: Int, name :: String } deriving (Eq)
type School = [Student]

instance Ord Student where
  compare (Student g1 n1) (Student g2 n2) 
    | g1 /= g2 = compare g1 g2
    | otherwise = compare n1 n2


add :: Int -> String -> School -> School
add gradeNum student school = Student {gradeNum=gradeNum, name=student}:school

empty :: School
empty = []

grade :: Int -> School -> [String]
grade gradeNum' = sort . map name . filter (\x -> gradeNum x == gradeNum')

sorted :: School -> [(Int, [String])]
sorted school = map (\x -> (x, grade x school)) grades  
  where 
    grades = sort $ nub $ map gradeNum school