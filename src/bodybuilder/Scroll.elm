module Scroll exposing (..)

import BodyBuilder exposing (..)
import Json.Decode as Decode


onScroll : (ScrollEvent -> value) -> OnEvent value a -> OnEvent value a
onScroll tagger =
    on "scroll" (Decode.map tagger onScrollJsonParser)


onScrollJsonParser : Decode.Decoder ScrollEvent
onScrollJsonParser =
    Decode.map3 ScrollEvent
        (Decode.at [ "target", "scrollHeight" ] Decode.int)
        (Decode.at [ "target", "scrollTop" ] Decode.int)
        (Decode.at [ "target", "clientHeight" ] Decode.int)


verticalParallax :
    Float
    -> { a | scrollPos : Int }
    -> Node msg
    -> Node msg
verticalParallax speed scrollEvent el =
    let
        toto =
            Basics.max ((scrollEvent.scrollPos |> toFloat) * speed |> round) 0
    in
        div [ style [ Elegant.positionAbsolute ] ]
            [ div [ style [ Elegant.marginTop (Px -toto) ] ] []
            , el
            , div
                [ style [ Elegant.marginTop (Px toto) ] ]
                []
            ]


type alias ScrollEvent =
    { scrollHeight : Int
    , scrollPos : Int
    , visibleHeight : Int
    }


visiblePortion : ScrollEvent -> Float
visiblePortion { scrollPos, scrollHeight, visibleHeight } =
    (scrollPos |> toFloat) / ((scrollHeight - visibleHeight) |> toFloat)
