module Helpers.Style exposing (..)

import Display


type alias StyleAndScreenWidths =
    { display : Maybe Display.DisplayBox
    , screenWidths : List ScreenWidth
    }


type alias ScreenWidth =
    { min : Maybe Int
    , max : Maybe Int
    , style : Display.DisplayBox
    }
