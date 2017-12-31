module Result
    ( Result(..)
    , Problem(..)
    , map
    , flatten
    ) 
    where


import Prelude hiding (map)
import qualified Data.List as List
import Line (Line)


data Problem
    = NoModuleName
    | InvalidExposedFunctions
    | FileIsEmpty
    | BlockStartsWithOutFirstWord
    | BlockWasEmpty
    | FileHasNoModuleSection
    | UnrecognizedType [Line] String
    | TypeSignatureSyntaxIsWrong [Line]
    | None


data Result a
    = Problem Problem
    | Ok a


map :: (a -> b) -> Result a -> Result b
map f result =
    case result of
        Ok x ->
            Ok (f x)

        Problem problem ->
            Problem problem


flatten :: [Result a] -> Result [a]
flatten results =
    flattenHelper ([], results) 


flattenHelper :: ([a], [Result a]) -> Result [a] 
flattenHelper (xs, results) =
    case results of
        Problem problem : _ ->
            Problem problem

        Ok x : rest ->
            flattenHelper (x : xs, rest)  

        [] ->
            Ok (List.reverse xs)
            
