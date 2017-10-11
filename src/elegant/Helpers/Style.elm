module Helpers.Style exposing (..)

import Display


type alias Style =
    { display : Maybe Display.DisplayBox
    , screenWidths : List ScreenWidth
    , suffix : Maybe String
    }


setSuffix : String -> Style -> Style
setSuffix value style =
    { style | suffix = Just value }


type alias ScreenWidth =
    { min : Maybe Int
    , max : Maybe Int
    , style : Display.DisplayBox
    }
