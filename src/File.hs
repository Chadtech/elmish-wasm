module File
    ( Model(..)
    , fromString
    )
    where


import qualified Util as Util
import qualified Data.List as List
import Data (Result(..), Problem(..))
import Data.List.Split (splitOn)
import Flow 


data Model =
    Ctor
    { module_ :: String
    , imports :: Maybe String
    , functions :: String
    }


fromString :: String -> Result Model
fromString fileData =
    let
        lines =
            fileData
                |> splitOn "\n"
                |> List.map Util.trim
                |> List.filter isntEmpty
    in
    Ok (Ctor, lines)
        |> construct readModule
        |> construct readImports
        |> construct readFunctions
        |> prepareResult


prepareResult :: Result (Model, [String]) -> Result Model
prepareResult result =
    case result of
        Problem problem ->
            Problem problem

        Ok (model, lines) ->
            Ok model


construct :: ([String] -> Result (a, [String])) -> Result ((a -> b), [String]) -> Result (b, [String]) 
construct reader step =
    case step of
        Problem problem ->
            Problem problem

        Ok (ctor, lines) ->
            case reader lines of 
                Problem problem ->
                    Problem problem

                Ok (part, remainingLines) ->
                    Ok ((ctor part), remainingLines) 


-- READERS --


readImports :: [String] -> Result (Maybe String, [String])
readImports lines =
    let
        (imports, rest) =
            getImports lines
    in
    case imports of
        [] ->
            Ok (Nothing, rest)

        _ ->
            Ok (Just (concat imports), rest)


readFunctions :: [String] -> Result (String, [String])
readFunctions lines =
    Ok (concat lines, []) 


readModule :: [String] -> Result (String, [String])
readModule lines =
    case getFirstBlock lines of
        Nothing ->
            Problem FileHasNoModuleSection

        Just (firstBlock, rest) ->
            case firstBlock of
                firstLine : _ ->
                    case Util.firstWord firstLine of
                        Just "module" ->
                            Ok (concat firstBlock, rest)

                        _ ->
                            Problem FileHasNoModuleSection

                [] ->
                    Problem FileIsEmpty


getImports :: [String] -> ([String], [String])
getImports lines =
    case lines of
        [] ->
            ([], [])

        _ ->
            getImportsHelper ([], lines) 


getImportsHelper :: ([String], [String]) -> ([String], [String])
getImportsHelper (imports, lines) =
    case lines of
        firstLine : rest ->
            case Util.firstWord firstLine of
                Just "import" ->
                    getImportsHelper (firstLine : imports, rest) 
        
                _ ->
                    (imports, lines)

        [] ->
            (imports, lines)


getFirstBlock :: [String] -> Maybe ([String], [String])
getFirstBlock lines = 
    case lines of
        [] ->
            Nothing

        _ ->
            ([], lines)
                |> firstBlockHelper
                |> Just


firstBlockHelper :: ([String], [String]) -> ([String], [String])
firstBlockHelper (firstBlock, lines) =
    case lines of
        first : rest ->
            if startsWithWhitespace first then
                (List.reverse firstBlock, lines)
            else
                firstBlockHelper (first : firstBlock, rest)

        [] ->
            (List.reverse firstBlock, [])



-- HELPERS --


startsWithWhitespace :: String -> Bool
startsWithWhitespace (' ' : rest) = True
startsWithWhitespace _ = False


isntEmpty :: String -> Bool
isntEmpty "" = False
isntEmpty _ = True

