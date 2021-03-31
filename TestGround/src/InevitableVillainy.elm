module InevitableVillainy exposing (..)

import Dict exposing (Dict)


type alias ScriptData =
    Dict String (List String)


scriptData : ScriptData
scriptData = 
    Dict.fromList [ ("Scene one", [ """Hi.""", """Hi there. """, """And you look good today,""", """Aloha!""", """Be nice.

Or naughty.""" ]), ("Scene two", [ """Hey.""", """How's it going?""" ]) ]