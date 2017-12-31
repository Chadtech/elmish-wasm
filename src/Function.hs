module Function
    ( Model(..) 
    , read    
    )
    where

import Data (Type(..))
import qualified Util as Util
import Flow
import Prelude hiding (read)
import Result (Problem(..), Result(..))
import Line (Line)


data Model =
    Ctor
    { name :: String
    , purportedTypeSignature :: Maybe [ Type ]
    , derivedTypeSignature :: [ Type ]
    }


read :: [Line] -> Result Model
read block =
    Problem None
