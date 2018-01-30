module DatetimePicker exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Events as Events
import Elegant exposing (px, vh, percent, Style, deg)
import Border
import Style
import Box
import Block
import Transform
import Position
import Padding
import Typography
import Json.Decode as Decode
import Mouse
import Constants


type Msg
    = TouchStart Mouse.Position
    | TouchAt Mouse.Position
    | TouchEnd Mouse.Position


type alias Model =
    { holdable : Holdable
    , yPosition : Int
    , ySpeed : Int
    }


type alias YSpeed =
    Int


type Holdable
    = Hold Touch
    | Release YSpeed


type alias Touch =
    { yStart : Int
    , yCurrent : Int
    }


initTouch : Int -> Touch
initTouch y =
    Touch y y


interpolateYPosition : Model -> Int
interpolateYPosition { holdable, yPosition } =
    case holdable of
        Hold touch ->
            yPosition - (touch.yCurrent - touch.yStart)

        _ ->
            yPosition


updateHoldable : a -> { c | holdable : b } -> { c | holdable : a }
updateHoldable b a =
    { a | holdable = b }


updateYPosition : a -> { c | yPosition : b } -> { c | yPosition : a }
updateYPosition b a =
    { a | yPosition = b }


touchStart : Int -> Model -> Model
touchStart =
    updateHoldable << Hold << initTouch


updateCurrentY : Int -> Holdable -> Holdable
updateCurrentY yCurrent holdable =
    case holdable of
        Hold touch ->
            Hold { touch | yCurrent = yCurrent }

        _ ->
            Hold (initTouch yCurrent)


touchMove : Int -> Model -> Model
touchMove yCurrent model =
    model
        |> updateHoldable (updateCurrentY yCurrent model.holdable)


touchEnd : Int -> Model -> Model
touchEnd y model =
    model
        |> updateHoldable (Release model.ySpeed)
        |> updateYPosition (interpolateYPosition model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TouchStart { y } ->
            ( model |> touchStart y, Cmd.none )

        TouchAt { y } ->
            ( model |> touchMove y, Cmd.none )

        TouchEnd { y } ->
            ( model |> touchEnd y, Cmd.none )


rotatedDiv : Float -> String -> Int -> Elegant.SizeUnit -> Node msg
rotatedDiv angle text height translationZ =
    Builder.div
        [ Attributes.style
            [ Style.blockProperties
                [ Block.height (px height)
                , Block.width (px 300)
                , Block.alignCenter
                ]
            , Style.box
                [ Box.transform
                    [ Transform.rotateX (deg angle)
                    , Transform.translateZ translationZ
                    , Transform.backfaceVisibilityHidden
                    ]
                , Box.typography
                    [ Typography.size (px 20)
                    , Typography.lineHeight (px height)
                    ]
                , Box.border
                    [ Border.all
                        [ Border.thickness (px 1)
                        , Border.solid
                        ]
                    ]
                , Box.position <|
                    Position.absolute
                        []
                ]
            ]
        ]
        [ Builder.text text ]


carousel : List String -> Int -> Float -> Node msg
carousel list height rotation =
    let
        length =
            List.length list
    in
        Builder.div
            [ Attributes.style
                [ Style.blockProperties
                    [ Block.width (px 300)
                    , Block.height (px height)
                    ]
                , Style.box
                    [ Box.transform
                        [ Transform.preserve3d
                        , Transform.perspective (px 1000)
                        ]
                    ]
                ]
            ]
            [ Builder.div
                [ Attributes.style
                    [ Style.box
                        [ Box.transform
                            [ Transform.rotateX (deg (rotation / 2))
                            , Transform.preserve3d
                            , Transform.origin ( Constants.zero, px ((toFloat height) / 2 |> round), Constants.zero )
                            ]
                        ]
                    ]
                ]
                (List.indexedMap
                    (\i e ->
                        (rotatedDiv
                            (-(((i |> toFloat)) + ((length |> toFloat) / 2))
                                * (360 / (length |> toFloat))
                            )
                        )
                            e
                            height
                            (px (Basics.round (((height |> toFloat) / 2) / Basics.tan (Basics.pi / (length |> toFloat)))))
                    )
                    list
                )
            ]


view : Model -> Node Msg
view model =
    Builder.div
        [ Attributes.style
            [ Style.box
                [ Box.padding
                    [ Padding.left (px 200)
                    , Padding.top (px 200)
                    ]
                ]
            ]
        , Events.on "mousedown" (Decode.map TouchStart Mouse.position)
        ]
        [ carousel
            [ "19 janvier 2017"
            , "20 janvier 2017"
            , "21 janvier 2017"
            , "22 janvier 2017"
            , "23 janvier 2017"
            , "24 janvier 2017"
            , "25 janvier 2017"
            , "26 janvier 2017"
            , "27 janvier 2017"
            ]
            116
            (interpolateYPosition model |> toFloat)
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        (case model.holdable of
            Hold touch ->
                [ Mouse.moves TouchAt
                , Mouse.ups TouchEnd
                ]

            Release speed ->
                []
        )


main : Program Basics.Never Model Msg
main =
    Builder.program
        { init = ( Model (Release 0) 0 0, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
