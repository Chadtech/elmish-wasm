module Util 
    ( firstWord
    , trim
    , log_
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


firstWord :: String -> Maybe String
firstWord fileData =
    fileData =~~ "([^ ]+)"


log_ :: String -> (a -> String) -> a -> a
log_ msg toString x =
    Debug.trace (msg ++ " : " ++ (toString x)) x

