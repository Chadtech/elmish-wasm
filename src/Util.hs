module Util 
    ( firstWordRegex
    , trim
    )
    where

import Text.Regex.Posix
import qualified Data.List as List
import qualified Data.Char as Char


trim :: String -> String
trim = 
    List.dropWhileEnd Char.isSpace . List.dropWhile Char.isSpace

firstWordRegex :: String -> String
firstWordRegex fileData =
    fileData =~ "([^ ]+)"

