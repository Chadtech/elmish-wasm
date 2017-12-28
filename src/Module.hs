module Module 
    ( Model(..) 
    , readName
    , readExposedFunctions
    , readFunctions
    , write
    )
    where


import Data (Result(..), Problem(..))
import Text.Regex.Posix
import Data.List as List
import Data.List.Split (splitOn)
import Flow
import qualified Util
import qualified Function


-- TYPES --


data Model =
    Ctor
    { name :: String
    , exposing :: Exposing
    , functions :: [ Function.Model ]
    }


data Exposing 
    = All
    | Only [ String ]



-- READ --


readName :: String -> Result String
readName fileData =
    case nameRegex fileData of
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


readExposedFunctions :: String -> Result Exposing
readExposedFunctions fileData =
    case nameRegex fileData of
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


readFunctions :: String -> Result [ Function.Model ]
readFunctions fileData =
    Ok []


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
    case Module.exposing model of
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

