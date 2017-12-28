module File
    ( Model(..)
    , fromString
    )
    where


import qualified Util as Util
import qualified Data.List as List
import Data (Result(..))
import Data.List.Split (splitOn)
import Flow 

data Model =
    Ctor
    { moduleDeclaration :: String
    , imports :: Maybe String
    , functions :: String
    }



fromString :: String -> Result Model
fromString fileData =
    let
        lines =
            fileData
                |> splitOn "\n"
                |> List.map Util.trim
                |> Util.consoleLog "Lines" show
    in
    Ok (Ctor "" Nothing "")
    -- (Ok Ctor, lines)
    --     |> 


-- parse :: (Result (a -> b), [ String ]) -> (a -> b) -> (Result b, [ String ])



--     fileData
--         |> splitOn "\n"
