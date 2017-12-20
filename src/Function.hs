module Function
    ( Model(..) )
    where

import Data (Type(..))


data Model =
    Ctor
    { name :: String
    , purportedTypeSignature :: [ Type ]
    , derivedTypeSignature :: [ Type ]
    }