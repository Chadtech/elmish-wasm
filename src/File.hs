module File
    ( Model(..)
    , fromString
    )
    where


import qualified Util as Util
import qualified Data.List as List
import Result (Result(..), Problem(..))
import Data.List.Split (splitOn)
import Flow 
import Line (Line)
import qualified Line as Line


data Model =
    Ctor
    { module_ :: [Line] 
    , imports :: [Line] 
    , parts :: [Line]
    }


fromString :: String -> Result Model
fromString fileData =
    Ok (Ctor, Line.fromString fileData)
        |> construct readModule
        |> construct readImports
        |> construct readParts 
        |> prepareResult


prepareResult :: Result (Model, [Line]) -> Result Model
prepareResult result =
    case result of
        Problem problem ->
            Problem problem

        Ok (model, lines) ->
            Ok model


construct :: ([Line] -> Result (a, [Line])) -> Result ((a -> b), [Line]) -> Result (b, [Line]) 
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


readImports :: [Line] -> Result ([Line], [Line])
readImports lines =
    readImportsHelper ([], lines)
        |> Ok
        

readImportsHelper :: ([Line], [Line]) -> ([Line], [Line])
readImportsHelper (imports, lines) =
    case lines of
        first : rest ->
            case Line.firstWord first of
                Just "import" ->
                    readImportsHelper (first : imports, rest) 
        
                _ ->
                    (imports, lines)

        [] ->
            (imports, lines)


readParts :: [Line] -> Result ([Line], [Line])
readParts lines =
    Ok (lines, []) 


readModule :: [Line] -> Result ([Line], [Line])
readModule lines =
    case Line.getFirstBlock lines of
        Nothing ->
            Problem FileHasNoModuleSection

        Just (firstBlock, rest) ->
            case firstBlock of
                first : _ ->
                    case Line.firstWord first of
                        Just "module" ->
                            Ok (firstBlock, rest)

                        _ ->
                            Problem FileHasNoModuleSection

                [] ->
                    Problem FileIsEmpty


