module DatetimePicker exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Events as Events
import Elegant exposing (px, vh, percent, Style, deg)
import Style
import Box
import Block
import Transform
import Position
import Padding
import Typography
import Constants
import AnimationFrame
import Time exposing (Time)
import Task
import List.Extra
import SingleTouch
import Mouse
import Touch exposing (Coordinates)


setHoldState : a -> { c | holdState : b } -> { c | holdState : a }
setHoldState b a =
    { a | holdState = b }


setHoldStateIn : { c | holdState : b } -> a -> { c | holdState : a }
setHoldStateIn =
    flip setHoldState


setPosition : a -> { c | position : b } -> { c | position : a }
setPosition b a =
    { a | position = b }


setCurrentY : a -> { c | yCurrent : b } -> { c | yCurrent : a }
setCurrentY b a =
    { a | yCurrent = b }


type Msg
    = TouchStart Coordinates
    | TouchAt Coordinates
    | TouchEnd TouchHistory Coordinates
    | OnTime Time
    | NewTime Time


type alias Model =
    { holdState : HoldState
    , position : Float
    }


type alias Speed =
    Float


type HoldState
    = Held TouchHistory
    | Released ( Time, Speed )


type alias TouchHistory =
    { yStart : Float
    , yCurrent : Float
    , lastPositions : List ( Float, Time )
    }


initTouch : Float -> TouchHistory
initTouch y =
    TouchHistory y y []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch <|
        case model.holdState of
            Held touch ->
                []

            Released ( _, speed ) ->
                if (speed < -0.05 || speed > 0.05) then
                    [ AnimationFrame.times NewTime ]
                else
                    []


addAndDropIfLimit : Int -> a -> List a -> List a
addAndDropIfLimit limit e list =
    list
        |> addAndDropIfLimitCounter limit 1
        |> (::) e


addAndDropIfLimitCounter : Int -> Int -> List a -> List a
addAndDropIfLimitCounter limit count list =
    case list of
        [] ->
            []

        hd :: tl ->
            if count >= limit then
                []
            else
                tl
                    |> addAndDropIfLimitCounter limit (count + 1)
                    |> (::) hd


getTime : Cmd Msg
getTime =
    Task.perform OnTime Time.now


interpolateYPosition : Model -> Float
interpolateYPosition { holdState, position } =
    case holdState of
        Held touch ->
            position - (touch.yCurrent - touch.yStart)

        _ ->
            position


updateCurrentPositionIn : HoldState -> Float -> HoldState
updateCurrentPositionIn holdable yCurrent =
    Held <|
        case holdable of
            Held touch ->
                touch |> setCurrentY yCurrent

            _ ->
                initTouch yCurrent


getTimeAndSpeed lastPositions =
    case lastPositions of
        [] ->
            ( 0, 0 )

        [ e ] ->
            ( 0, 0 )

        ( lastYPosition, lastTime ) :: l ->
            case List.Extra.last l of
                Just ( oldYPosition, oldTime ) ->
                    ( lastTime
                    , 2
                        * (lastYPosition - oldYPosition)
                        / (lastTime - oldTime)
                    )

                Nothing ->
                    ( 0, 0 )


applyAndChangeSpeed : Time.Time -> Time.Time -> Speed -> Model -> Model
applyAndChangeSpeed lastTime newTime ySpeed model =
    { model
        | position =
            model.position - (ySpeed * (newTime - lastTime))
    }
        |> setHoldState
            (Released
                ( newTime
                , ySpeed
                    * (0.99
                        ^ ((round (newTime - lastTime))
                            % 17
                            |> toFloat
                          )
                      )
                )
            )


createOrChangeLastPositions : Time.Time -> TouchHistory -> Model -> Model
createOrChangeLastPositions newTime touch model =
    model
        |> setHoldState
            (Held
                { touch
                    | lastPositions =
                        addAndDropIfLimit 5
                            ( touch.yCurrent, newTime )
                            touch.lastPositions
                }
            )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TouchStart { clientY } ->
            ( model |> touchStart clientY, Cmd.none )

        TouchAt { clientY } ->
            ( model |> touchMove clientY, getTime )

        TouchEnd touch { clientY } ->
            ( model |> touchEnd touch clientY, getTime )

        OnTime time ->
            ( model
                |> (case model.holdState of
                        Held touch ->
                            createOrChangeLastPositions time touch

                        Released ( lastTime, ySpeed ) ->
                            applyAndChangeSpeed lastTime time ySpeed
                   )
            , Cmd.none
            )

        NewTime time ->
            ( case model.holdState of
                Held touch ->
                    model

                Released ( lastTime, ySpeed ) ->
                    applyAndChangeSpeed lastTime time ySpeed model
            , Cmd.none
            )


touchStart : Float -> Model -> Model
touchStart =
    initTouch
        >> Held
        >> setHoldState


touchMove : Float -> Model -> Model
touchMove currentPosition ({ holdState } as model) =
    currentPosition
        |> updateCurrentPositionIn holdState
        |> setHoldStateIn model


touchEnd : TouchHistory -> Float -> Model -> Model
touchEnd lastTouch y model =
    lastTouch.lastPositions
        |> getTimeAndSpeed
        |> Released
        |> setHoldStateIn model
        |> setPosition (interpolateYPosition model)


main : Program Basics.Never Model Msg
main =
    Builder.program
        { init = Model (Released ( 0, 0 )) 0 ! []
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- View


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
                            , Transform.origin
                                ( Constants.zero
                                , px
                                    ((toFloat height)
                                        / 2
                                        |> round
                                    )
                                , Constants.zero
                                )
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
                            (px
                                (Basics.round
                                    (((height |> toFloat)
                                        / 2
                                     )
                                        / Basics.tan
                                            (Basics.pi
                                                / (length |> toFloat)
                                            )
                                    )
                                )
                            )
                    )
                    list
                )
            ]


view : Model -> Node Msg
view model =
    Builder.div
        ([ Attributes.style
            [ Style.box
                [ Box.padding
                    [ Padding.left (px 200)
                    , Padding.top (px 200)
                    ]
                ]
            ]
         , Attributes.rawAttribute <| SingleTouch.onStart TouchStart
         ]
            ++ (case model.holdState of
                    Held touch ->
                        [ Attributes.rawAttribute <| SingleTouch.onMove TouchAt
                        , Attributes.rawAttribute <| SingleTouch.onEnd (TouchEnd touch)
                        ]

                    Released ( timeTime, ySpeed ) ->
                        []
               )
        )
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
            (interpolateYPosition model)
        ]
