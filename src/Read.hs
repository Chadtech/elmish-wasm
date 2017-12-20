module Read
    (file)
    where

import qualified Module
import Data (Problem(..))
import Flow
import Text.Regex.Posix


parse :: String -> (String -> Either Problem a) -> (a -> b) -> Either Problem b
parse fileData parser ctor =
    case parser fileData of
        Left problem ->
            Left problem 

        Right moduleName ->
            Right (ctor moduleName)


file :: String -> Either Problem Module.Model
file fileData =
    Module.Ctor
        |> parse fileData getModuleName


getModuleName :: String -> Either Problem String
getModuleName fileData =
    case fileData =~ "module " of
        ("", "module ", after) ->
            Right (firstWordRegex after)

        _ ->
            Left NoModuleName

-- REGEX --


firstWordRegex :: String -> String
firstWordRegex fileData =
    fileData =~ "([^ ]+)"