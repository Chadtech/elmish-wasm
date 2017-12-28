module Util 
    ( firstWordRegex
    , trim
    , consoleLog
    )
    where

import Text.Regex.Posix
import qualified Data.List as List
import qualified Data.Char as Char
import qualified Debug.Trace as Debug
import Flow

trim :: String -> String
trim = 
    List.dropWhileEnd Char.isSpace 
        >> List.dropWhile Char.isSpace


firstWordRegex :: String -> String
firstWordRegex fileData =
    fileData =~ "([^ ]+)"



consoleLog :: String -> (a -> String) -> a -> a
consoleLog msg toString x =
    Debug.trace (msg ++ " : " ++ (toString x)) x
