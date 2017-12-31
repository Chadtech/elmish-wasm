module Module 
    ( readName
    , readExposedParts
    , readParts
    , write
    )
    where


import Line (Line)
import Result (Result(..), Problem(..))
import qualified Result
import qualified Line 
import qualified Part
import Part (Part(..))
import Text.Regex.Posix
import Data.List as List
import Data.List.Split (splitOn)
import Flow
import qualified Util
import qualified Function
import Data.Module 
    ( Model(..)
    , Exposing (..)
    )


-- READ --


readName :: [Line] -> Result String
readName lines =
    case nameRegex (Line.toString lines) of 
        ("", moduleName, _) ->
            Ok (List.drop 7 moduleName)

        _ ->
            Problem NoModuleName


nameRegex :: String -> (String, String, String)
nameRegex fileData =
    fileData =~ "module [A-Za-z]*"


exposingRegex :: String -> Maybe String
exposingRegex fileData =
    fileData =~~ "exposing[ \t\n]*\\(.*\\)"


readExposedParts :: [Line] -> Result Exposing
readExposedParts lines =
    case nameRegex (Line.toString lines) of
        ("", moduleName, after) ->
            case exposingRegex after of
                Just "(..)" ->
                    Ok All

                Just functions ->
                    functions
                        |> List.drop 10
                        |> reverse
                        |> List.drop 1
                        |> reverse
                        |> splitOn ","
                        |> List.map Util.trim
                        |> Only
                        |> Ok

                Nothing ->
                    Problem InvalidExposedFunctions

        _ ->
            Problem NoModuleName


readParts :: [Line] -> Result [Part]
readParts lines =
    lines
        |> Line.filterEmpties
        |> Line.toBlocks
        |> List.map Part.read 
        |> Result.flatten




-- WRITE --


write :: Model -> String
write model =
    "( module " ++ (writeBody model) ++ ")"


writeBody :: Model -> String
writeBody model =
    (writeFunctions model) ++ (writeExports model)


writeFunctions :: Model -> String
writeFunctions model =
    ""


writeExports :: Model -> String
writeExports model =
    case Data.Module.exposing model of
        All ->
            ""

        Only functionNames ->
            functionNames
                |> List.map writeExport
                |> concat


writeExport :: String -> String
writeExport functionName =
    [ "( export \""
    , functionName
    , "\" (func $"
    , functionName
    , ")) "
    ]
        |> concat

