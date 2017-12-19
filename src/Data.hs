module Data 
    ( Module(..)
    , Function
    , Type(..)
    , Problem(..)
    ) where

import qualified Data.Map as Map
import Flow


data Module =
    Module
    { moduleName :: String
    -- , functions :: Map.Map String Function
    }


data Function =
    Function
    { functionName :: String
    , typeSignature :: [ Type ]
    , exposed :: Bool
    }


data Type = Int_ | Float_ | Bool_


data Problem
    = NoModuleName