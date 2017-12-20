module Function
    ( Model(..) )
    where

import Data (Type(..))


data Model =
    Ctor
    { name :: String
    , purportedTypeSignature :: Maybe [ Type ]
    , derivedTypeSignature :: [ Type ]
    }