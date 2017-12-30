module Data 
    ( Type(..)
    , Problem(..)
    , Result(..)
    ) where

import Flow


data Type 
    = Int_ 
    | Float_ 
    | Bool_


data Problem
    = NoModuleName
    | FileHasNoModuleSection
    | InvalidExposedFunctions
    | FileIsEmpty



data Result a
    = Problem Problem
    | Ok a
