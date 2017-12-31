module Part
    ( Part(..)
    , read
    )
    where


import qualified Function
import Line (Line)
import qualified Line
import Result (Result(..), Problem(..))
import qualified Result
import Prelude hiding (read)
import qualified Util
import qualified Data.List as List
import Flow


data Part
    = Function Function.Model

read :: [Line] -> Result Part
read block =
    case block of
        first : _ ->
            case Line.firstWord first of
                Just name ->
                    block
                        |> Function.read
                        |> Result.map Function

                Nothing ->
                    Problem BlockStartsWithOutFirstWord

        [] ->
            Problem BlockWasEmpty
        

