module Part
    ( Part(..)
    , read
    , write
    )
    where


import Text.Regex.Posix
import Data.List.Split (splitOn)
import qualified Function
import Line (Line)
import qualified Line
import Result (Result(..), Problem(..))
import qualified Result
import Prelude hiding (read)
import qualified Util
import qualified Data.List as List
import Flow
import Data (Type(..))


data Part
    = Function Function.Model
    | TypeSignature String [Type] 


read :: [Line] -> Result Part
read block =
    case block of
        first : _ ->
            case Line.regex firstWord first of
                Just name ->
                    if Line.regex isTypeSignature first then
                        block
                            |> readTypeSignature name
                    else
                        block
                            |> Function.read name
                            |> Result.map Function

                Nothing ->
                    Problem BlockStartsWithOutFirstWord

        [] ->
            Problem BlockWasEmpty


readTypeSignature :: String -> [Line] -> Result Part
readTypeSignature name block =
    case getSignaturePart (Line.toString block) of
        (_, ":", signaturePart) ->
            signaturePart
                |> splitOn "->"
                |> List.map Util.trim
                |> List.map (readType block)
                |> Result.flatten
                |> Result.map (TypeSignature name)

        _ ->
            Problem (TypeSignatureSyntaxIsWrong block)


readType :: [Line] -> String -> Result Type
readType block str =
    case str of
        "Int" ->
            Ok Int_

        "Float" ->
            Ok Float_

        "Bool" ->
            Ok Bool_

        _ ->
            Problem (UnrecognizedType block str)


getSignaturePart :: String -> (String, String, String)
getSignaturePart str =
    str =~ ":"
       

firstWord :: String -> Maybe String
firstWord str =
    str =~~ "[a-z][A-Za-z0-9]* "


isTypeSignature :: String -> Bool
isTypeSignature str =
    str =~ "[a-z][A-Za-z0-9]* *:"


-- WRITE --


write :: Part -> String
write part =
    case part of
        Function model ->
            Function.write model

        TypeSignature name types ->
            ""

