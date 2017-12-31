module Module.Data
    ( Model(..)
    , Part(..)
    , Exposing(..)
    )
    where


import qualified Function


data Model =
    Ctor
    { name :: String
    , exposing :: Exposing
    , parts :: [ Part ]
    }


data Exposing 
    = All
    | Only [ String ]


data Part
    = FunctionTypeSignature
    | Function Function.Model
    | UnionType



