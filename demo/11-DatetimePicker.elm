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
import AnimationFrame
import Time
import Task
import List.Extra


type Msg
    = TouchStart Mouse.Position
    | TouchAt Touch Mouse.Position
    | TouchEnd Touch Mouse.Position
    | NewTime Time.Time
    | OnTime Touch Time.Time


addAndDropIfLimit : Int -> a -> List a -> List a
addAndDropIfLimit limit e list =
    addAndDropIfLimitCounter limit 1 list
        |> (::) e


addAndDropIfLimitCounter : Int -> Int -> List a -> List a
addAndDropIfLimitCounter limit count list =
    case list of
        [] ->
            []

        x :: xs ->
            if count >= limit then
                []
            else
                addAndDropIfLimitCounter limit (count + 1) xs
                    |> (::) x


getTime : Touch -> Cmd Msg
getTime touch =
    Task.perform (OnTime touch) Time.now


type alias Model =
    { holdable : Holdable
    , yPosition : Int
    }


type alias YSpeed =
    Float


type Holdable
    = Hold Touch
    | Release YSpeed


type alias Touch =
    { yStart : Int
    , yCurrent : Int
    , lastYPositions : List ( Int, Time.Time )
    }


initTouch : Int -> Touch
initTouch y =
    Touch y y []


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
    Hold
        (case holdable of
            Hold touch ->
                { touch | yCurrent = yCurrent }

            _ ->
                (initTouch yCurrent)
        )


touchMove : Touch -> Int -> Model -> Model
touchMove lastTouch yCurrent model =
    model
        |> updateHoldable (updateCurrentY yCurrent model.holdable)



-- |> updateTime Time.now


touchEnd : Touch -> Int -> Model -> Model
touchEnd lastTouch y model =
    let
        ySpeed =
            case lastTouch.lastYPositions of
                [] ->
                    0

                [ e ] ->
                    0

                ( lastYPosition, lastTime ) :: l ->
                    case (List.Extra.last l) of
                        Just ( oldYPosition, oldTime ) ->
                            (toFloat (lastYPosition - oldYPosition)) / (lastTime - oldTime)

                        Nothing ->
                            0

        -- (if (List.length touch.lastYPositions) <= 10 then
        --     newTime :: touch.lastYPositions
        --  else
        --     case (List.Extra.init touch.lastYPositions) of
        --         Just lastYPositionsPoped ->
        --             newTime :: lastYPositionsPoped
        --
        --         Nothing ->
        --             [ newTime ]
        -- )
    in
        model
            |> updateHoldable (Release ySpeed)
            |> updateYPosition (interpolateYPosition model)


changeSpeed : Time.Time -> YSpeed -> Model -> Model
changeSpeed newTime ySpeed model =
    { model | yPosition = model.yPosition - (round ySpeed) }
        |> updateHoldable (Release (ySpeed * 0.99))


createOrChangeLastPositions : Time.Time -> Touch -> Model -> Model
createOrChangeLastPositions newTime touch model =
    model
        |> updateHoldable
            (Hold
                { touch
                    | lastYPositions = addAndDropIfLimit 10 ( touch.yCurrent, newTime ) touch.lastYPositions

                    -- (if (List.length touch.lastYPositions) <= 10 then
                    --     newTime :: touch.lastYPositions
                    --  else
                    --     case (List.Extra.init touch.lastYPositions) of
                    --         Just lastYPositionsPoped ->
                    --             newTime :: lastYPositionsPoped
                    --
                    --         Nothing ->
                    --             [ newTime ]
                    -- )
                }
            )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TouchStart { y } ->
            ( model |> touchStart y, Cmd.none )

        TouchAt touch { y } ->
            ( model |> touchMove touch y, getTime touch )

        TouchEnd touch { y } ->
            ( model |> touchEnd touch y, getTime touch )

        OnTime touch time ->
            ( model
                |> (case model.holdable of
                        Hold touch ->
                            createOrChangeLastPositions time touch

                        Release ySpeed ->
                            changeSpeed time ySpeed
                   )
            , Cmd.none
            )

        NewTime time ->
            ( case model.holdable of
                Hold touch ->
                    model

                Release ySpeed ->
                    changeSpeed time ySpeed model
            , Cmd.none
            )


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
                    , Typography.userSelect (False)
                    ]
                , Box.border
                    [ Border.all
                        [ Border.thickness (px 3)
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
                [ Mouse.moves (TouchAt touch)
                , Mouse.ups (TouchEnd touch)
                ]

            Release speed ->
                (if ((truncate speed) /= 0) then
                    [ AnimationFrame.times NewTime ]
                 else
                    []
                )
        )


main : Program Basics.Never Model Msg
main =
    Builder.program
        { init = ( Model (Release 0) 0, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
