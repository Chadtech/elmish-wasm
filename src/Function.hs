module Function
    ( Model(..) 
    , read    
    , write
    )
    where

import Data (Type(..))
import qualified Util as Util
import Flow
import Prelude hiding (read)
import Result (Problem(..), Result(..))
import Line (Line)
import qualified Data.List as List


data Model =
    Ctor
    { name :: String }


read :: String -> [Line] -> Result Model
read name_ block =
    Ok (Ctor name_)


write :: Model -> String
write model =
    [ "(func"
    , "$" ++ name model
    , ")"
    ]
        |> List.intercalate " "
