module Data 
    ( Type(..)
    , Problem(..)
    , Result(..)
    ) where

import qualified Data.Map as Map
import Flow


data Type 
    = Int_ 
    | Float_ 
    | Bool_


data Problem
    = NoModuleName
    | InvalidExposedFunctions


data Result a
    = Problem Problem
    | Ok a