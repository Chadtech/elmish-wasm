module Main where

import qualified System.Environment as System
import qualified Data.ByteString as Byte
import qualified Data.Map as Map
import Flow
import qualified Data.ByteString.Char8 as C
import qualified Module
import Data (Problem(..), Result(..))
import qualified Read
import qualified Write


-- MAIN --


main :: IO ()
main = do
    args <- System.getArgs
    handleArgs args


handleArgs :: [ String ] -> IO ()
handleArgs [] = putStrLn "Error : No file was given. Try typing \"elmish fileName.elm\""
handleArgs (fn : _) = do
    file <- Byte.readFile fn
    file
        |> C.unpack
        |> Read.file
        |> handleResult


handleResult :: Result Module.Model -> IO ()
handleResult result =
    case result of
        Problem problem ->
            putStrLn (handleProblem problem)

        Ok module_ ->
            Write.wat module_


handleProblem :: Problem -> String
handleProblem problem =
    case problem of
        NoModuleName ->
            "Error : This file has no module name. The first line should start with the word \"module\" followed by the module name."

