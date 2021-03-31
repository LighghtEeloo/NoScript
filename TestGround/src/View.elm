module View exposing (..)

import Html exposing (Html, button, div, input, pre, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model)
import Script exposing (script)
import Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    let
        scriptText =
            case model.line of
                Just line ->
                    line

                Nothing ->
                    ""

        buffer =
            Maybe.withDefault "NAN" <| Maybe.map String.fromInt <| model.buffer
    in
    div []
        [ div []
            [ text <| "Current: ( " ++ model.section ++ ", " ++ buffer ++ " )"
            ]
        , div []
            [ text "Section: "
            , input
                [ onInput (\x -> Section x)
                , value model.section
                ]
                []
            ]
        , div []
            [ text <| "Index: "
            , input
                [ onInput (\x -> Select (Maybe.withDefault Nothing (Just (String.toInt x))))
                , value <| Maybe.withDefault "" <| Maybe.map String.fromInt <| model.buffer
                ]
                []
            ]
        , button [ onClick Decrement ] [ text "-" ]
        , button [ onClick Increment ] [ text "+" ]
        , div [] [ pre [] [ text scriptText ] ]
        ]
