module Update exposing (..)

import Model exposing (Model)
import Script exposing (flatten, scriptClamp, scriptSafe)


type Msg
    = Increment
    | Decrement
    | Select (Maybe Int)
    | Section String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        model_ =
            case msg of
                Increment ->
                    { model
                        | buffer =
                            case model.buffer of
                                Just buf ->
                                    Just (scriptClamp model.section <| buf + 1)

                                _ ->
                                    Just 0
                    }

                Decrement ->
                    { model
                        | buffer =
                            case model.buffer of
                                Just buf ->
                                    Just (scriptClamp model.section <| buf - 1)

                                _ ->
                                    Just 0
                    }

                Select sel ->
                    { model
                        | buffer = Maybe.map (scriptClamp model.section) sel
                    }

                Section sec ->
                    { model
                        | section = sec
                    }

        model__ =
            { model_ | line = flatten <| Maybe.map (scriptSafe model.section) <| model_.buffer }
    in
    ( model__, Cmd.none )
