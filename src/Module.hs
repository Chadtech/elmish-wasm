module Module 
    ( Model(..) 
    , readName
    , readExposedFunctions
    )
    where


import Util
import Data (Result(..), Problem(..))
import Text.Regex.Posix
import Data.List as List
import Data.List.Split (splitOn)
import Data.Text (strip)
import qualified Debug.Trace as Debug
import Flow
import qualified Util


data Model =
    Ctor
    { name :: String
    , exposing :: Exposing
    }


data Exposing 
    = All
    | Only [ String ]


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
                        |> List.drop 9
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




