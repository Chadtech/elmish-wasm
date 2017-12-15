module Main where

import qualified System.Environment as System
import qualified Data.ByteString as Byte
import qualified Data.Map as Map
import Flow
import Text.Regex.Posix
import qualified Data.ByteString.Char8 as C

main :: IO ()
main = do
    args <- System.getArgs
    handleArgs args


handleArgs :: [ String ] -> IO ()
handleArgs [] = putStrLn "Error : No file was given. Try typing \"elmish fileName.elm\""
handleArgs (fn : _) = do
    file <- Byte.readFile fn
    putStrLn (show (getModuleName (C.unpack file)))


getModuleName :: String -> Maybe String
getModuleName file =
    case file =~ "module " of
        ("", "module ", after) ->
            Just (firstWordRegex after)

        _ ->
            Nothing


firstWordRegex :: String -> String
firstWordRegex file =
    file =~ "([^ ]+)"


data Module =
    Module
    { moduleName :: String
    , functions :: Map.Map String Function
    }


data Function =
    Function
    { functionName :: String
    , typeSignature :: [ Type ]
    , exposed :: Bool
    }


data Type = Int_ | Float_ | Bool_

