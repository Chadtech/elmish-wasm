module Read
    (file)
    where

import qualified Module
import Data (Problem(..), Result(..))
import Flow
import Text.Regex.Posix
import qualified Data.List as List


construct :: String -> (String -> Result a) -> Result (a -> b) -> Result b
construct fileData reader step =
    case step of
        Problem problem ->
            Problem problem

        Ok ctor ->
            case reader fileData of
                Problem problem ->
                    Problem problem

                Ok part ->
                    Ok (ctor part)


file :: String -> Result Module.Model
file fileData =
    Ok Module.Ctor
        |> construct fileData Module.readName
        |> construct fileData Module.readExposedFunctions


