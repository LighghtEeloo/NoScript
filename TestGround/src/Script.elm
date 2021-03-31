module Script exposing (flatten, script, scriptClamp, scriptSafe)

import Dict
import InevitableVillainy exposing (ScriptData, scriptData)


lineImpl : Int -> List String -> Maybe String
lineImpl order data =
    case data of
        str :: rest ->
            if order == 0 then
                Just str

            else
                lineImpl (order - 1) rest

        _ ->
            Nothing


scriptImpl : String -> Int -> ScriptData -> Maybe String
scriptImpl key order data =
    Dict.get key data
        |> Maybe.map (\x -> lineImpl order x)
        |> flatten


scriptClamp : String -> Int -> Int
scriptClamp section nth =
    let
        len =
            Dict.get section scriptData
                |> Maybe.withDefault []
                |> List.length
    in
    clamp 0 (len - 1) nth


scriptSafe : String -> Int -> Maybe String
scriptSafe section nth =
    scriptImpl section nth scriptData


script : String -> Int -> String
script section nth =
    Maybe.withDefault "" <| scriptSafe section nth


flatten : Maybe (Maybe a) -> Maybe a
flatten maybeMaybe =
    Maybe.withDefault Nothing maybeMaybe
