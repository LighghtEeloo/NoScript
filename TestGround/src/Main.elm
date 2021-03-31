module Main exposing (..)

import Browser
import Model exposing (Model, init)
import Update exposing (Msg, update)
import View exposing (view)


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( init, Cmd.none )
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = view
        }
