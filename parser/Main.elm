module Main exposing (..)


type alias Module =
    { name : String
    , functions : Dict String Function
    }


type alias Function =
    { name : String
    , typeSignature : List Type
    , exposed : Bool
    }


type Type
    = Int_
    | Float_
    | Bool_
