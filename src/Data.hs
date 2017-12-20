module Data 
    ( Type(..)
    , Problem(..)
    ) where

import qualified Data.Map as Map
import Flow


data Type 
    = Int_ 
    | Float_ 
    | Bool_


data Problem
    = NoModuleName