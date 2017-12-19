module Main where

import qualified System.Environment as System
import qualified Data.ByteString as Byte
import qualified Data.Map as Map
import Flow
import Text.Regex.Posix
import qualified Data.ByteString.Char8 as C
import Data (Module(..), Problem(..))


main :: IO ()
main = do
    args <- System.getArgs
    handleArgs args


handleArgs :: [ String ] -> IO ()
handleArgs [] = putStrLn "Error : No file was given. Try typing \"elmish fileName.elm\""
handleArgs (fn : _) = do
    file <- Byte.readFile fn
    putStrLn (handleResult (getModule (C.unpack file)))


handleResult :: Either Problem Module -> String
handleResult result =
    case result of
        Left problem ->
            handleProblem problem

        Right module_ ->
            moduleName module_


handleProblem :: Problem -> String
handleProblem problem =
    case problem of
        NoModuleName ->
            "Error : This file has no module name. The first line should start with the word \"module\" followed by the module name."


getModule :: String -> Either Problem Module
getModule file =
    Module
        |> parse file getModuleName


parse :: String -> (String -> Either Problem a) -> (a -> b) -> Either Problem b
parse file parser ctor =
    case parser file of
        Left problem ->
            Left problem 

        Right moduleName ->
            Right (ctor moduleName)


getModuleName :: String -> Either Problem String
getModuleName file =
    case file =~ "module " of
        ("", "module ", after) ->
            Right (firstWordRegex after)

        _ ->
            Left NoModuleName


firstWordRegex :: String -> String
firstWordRegex file =
    file =~ "([^ ]+)"


