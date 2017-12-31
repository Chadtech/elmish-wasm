module Line
    ( Line
    , getIndex
    , getContent
    , fromString
    , toString
    , filterEmpties
    , firstWord
    , regex
    , getFirstBlock
    , toBlocks
    )
    where

import qualified Util as Util
import qualified Data.List as List
import Flow
import Data.List.Index (indexed)
import Data.List.Split (splitOn)


data Line =
    Line Int String


getIndex :: Line -> Int
getIndex (Line index _) =
    index


getContent :: Line -> String
getContent (Line _ content) =
    content


fromString :: String -> [Line]
fromString str = 
    str
        |> splitOn "\n"
        |> indexed
        |> List.map fromTuple


toString :: [Line] -> String
toString lines =
    lines
        |> List.map getContent
        |> List.intersperse "\n" 
        |> concat


fromTuple :: (Int, String) -> Line
fromTuple (index, str) =
    Line index str


filterEmpties :: [Line] -> [Line]
filterEmpties =
    List.filter isntEmpty 


firstWord :: Line -> Maybe String
firstWord line =
    getContent line |> Util.firstWord


regex :: (String -> a) -> Line -> a
regex r (Line _ str) =
    r str


isntEmpty :: Line -> Bool
isntEmpty (Line _ "") = False
isntEmpty (Line _ _) = True


startsWithSpace :: Line -> Bool
startsWithSpace (Line _ (' ' : rest)) = True
startsWithSpace _ = False


getFirstBlock :: [Line] -> Maybe ([Line], [Line])
getFirstBlock lines = 
    case lines of
        [] ->
            Nothing

        _ ->
            ([], lines)
                |> firstBlockHelper
                |> Just


firstBlockHelper :: ([Line], [Line]) -> ([Line], [Line])
firstBlockHelper (firstBlock, lines) =
    case lines of
        first : rest ->
            if startsWithSpace first then
                (List.reverse firstBlock, lines)
            else
                firstBlockHelper (first : firstBlock, rest)

        [] ->
            (List.reverse firstBlock, [])


toBlocks :: [Line] -> [[Line]]
toBlocks lines =
    toBlocksHelper (lines, [])


toBlocksHelper :: ([Line], [[Line]]) -> [[Line]]
toBlocksHelper (lines, blocks) =
    case getFirstBlock lines of
        Just (firstBlock, rest) ->
            toBlocksHelper (rest, firstBlock : blocks)

        Nothing ->
            blocks

