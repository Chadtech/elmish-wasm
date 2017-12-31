module Read
    (file)
    where

import qualified Data.Module as Module
import qualified Module
import Result (Result(..), Problem(..))
import Flow
import Text.Regex.Posix
import qualified Data.List as List
import Data.List.Split (splitOn)
import qualified File 


construct :: part -> (part -> Result a) -> Result (a -> b) -> Result b
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
    case File.fromString fileData of
        Ok file ->
            Ok Module.Ctor
                |> construct (File.module_ file) Module.readName
                |> construct (File.module_ file) Module.readExposedParts
                |> construct (File.parts file) Module.readParts
        
        Problem problem ->
            Problem problem

