module Model exposing (..)


type alias Model =
    { line : Maybe String
    , buffer : Maybe Int
    , section : String
    }


init : Model
init =
    { line = Nothing
    , buffer = Nothing
    , section = "Scene one"
    }
