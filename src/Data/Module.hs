module Data.Module
    ( Model(..)
    , Exposing(..)
    )
    where

import Part (Part(..))
import qualified Function


data Model =
    Ctor
    { name :: String
    , exposing :: Exposing
    , parts :: [Part]
    }


data Exposing 
    = All
    | Only [String]


