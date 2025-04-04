module BodyBuilder.Scroll exposing (..)

import BodyBuilder exposing (..)
import Json.Decode as Decode



onScrollJsonParser : Decode.Decoder ScrollEvent
onScrollJsonParser =
    Decode.map3 ScrollEvent
        (Decode.at [ "target", "scrollHeight" ] Decode.int)
        (Decode.at [ "target", "scrollTop" ] Decode.int)
        (Decode.at [ "target", "clientHeight" ] Decode.int)



type alias ScrollEvent =
    { scrollHeight : Int
    , scrollPos : Int
    , visibleHeight : Int
    }


visiblePortion : ScrollEvent -> Float
visiblePortion { scrollPos, scrollHeight, visibleHeight } =
    (scrollPos |> toFloat) / ((scrollHeight - visibleHeight) |> toFloat)
