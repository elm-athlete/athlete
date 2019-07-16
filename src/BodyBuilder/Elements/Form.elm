module BodyBuilder.Elements.Form exposing
    ( CommonParams
    , FullInputType
    , InputCheckboxContent
    , InputNumberContent
    , InputTextContent
    , buildCheckbox
    , buildDate
    , buildInput
    , buildInputFile
    , buildInputNumber
    , buildInputPassword
    , buildInputText
    , buildInputEmail
    , buildSelect
    , buildTextArea
    , checkBoxSurround
    , errorMessage
    , generateOptions
    , inputField
    , inputLabel
    , inputLabelPlaceholder
    , inputLabelPlaceholderWithError
    , inputLabelWithError
    , inputSurround
    , inputTextStyle
    , labelizedInput
    , InputType(..)
    )

{-|

@docs CommonParams
@docs FullInputType
@docs InputCheckboxContent
@docs InputNumberContent
@docs InputTextContent
@docs InputType(..)
@docs buildCheckbox
@docs buildDate
@docs buildInput
@docs buildInputFile
@docs buildInputNumber
@docs buildInputPassword
@docs buildInputText
@docs buildInputEmail
@docs buildSelect
@docs buildTextArea
@docs checkBoxSurround
@docs errorMessage
@docs generateOptions
@docs inputField
@docs inputLabel
@docs inputLabelPlaceholder
@docs inputLabelPlaceholderWithError
@docs inputLabelWithError
@docs inputSurround
@docs inputTextStyle
@docs labelizedInput

-}

import BodyBuilder as B exposing (FlexItem, NodeWithStyle)
import BodyBuilder.Attributes as A
import BodyBuilder.Elements.Clickable exposing (..)
import BodyBuilder.Events as E
import BodyBuilder.Extra exposing (..)
import BodyBuilder.Internals.Shared
import BodyBuilder.Router as Router
import BodyBuilder.Style as Style
import Color
import DateTime
import Elegant exposing (percent, px)
import Elegant.Block as Block
import Elegant.Border as Border
import Elegant.Box as Box
import Elegant.Constants as Constants
import Elegant.Cursor as Cursor
import Elegant.Display as Display
import Elegant.Extra exposing (..)
import Elegant.Flex as Flex
import Elegant.Grid as Grid
import Elegant.Grid.Extra as GridExtra
import Elegant.Margin as Margin
import Elegant.Outline as Outline
import Elegant.Overflow as Overflow
import Elegant.Padding as Padding
import Elegant.Typography as Typography
import Html
import Html.Events.Extra.Touch as Touch
import Ionicon
import Ionicon.Ios as Ios
import Json.Decode as Decode
import Modifiers exposing (..)
import Time exposing (Month(..), Posix)
import VirtualDom


borderColor : Color.Color
borderColor =
    Color.grayscale 0.1


monthToInt : Time.Month -> Int
monthToInt month =
    case month of
        Time.Jan ->
            1

        Time.Feb ->
            2

        Time.Mar ->
            3

        Time.Apr ->
            4

        Time.May ->
            5

        Time.Jun ->
            6

        Time.Jul ->
            7

        Time.Aug ->
            8

        Time.Sep ->
            9

        Time.Oct ->
            10

        Time.Nov ->
            11

        Time.Dec ->
            12


{-| -}
buildDate : CommonParams -> Maybe DateTime.DateTime -> DateBetween -> (DateMsg -> msg) -> NodeWithStyle msg
buildDate { label } maybeDate between msg =
    let
        years =
            case between of
                DateBetween after before ->
                    List.range
                        (after |> DateTime.getYear)
                        (before |> DateTime.getYear)

        days =
            List.range 1 31

        months =
            List.range 1 12

        -- years =
        --     List.range 1900 2030
        defaultYear =
            2015

        defaultMonth =
            2

        defaultDay =
            1
    in
    case maybeDate of
        Nothing ->
            inputSurround Nothing label <|
                monochromeSquaredButton
                    { background = Color.white
                    , border = Color.black
                    , text = Color.black
                    }
                    "Pick a date"
                    (msg SetDefaultDate)

        Just date ->
            inputSurround Nothing label <|
                B.flex [ displayBlock, spaceBetween ]
                    ([ inputField
                        (inputLabel "Year")
                        (Select (generateOptions ((date |> DateTime.getYear) |> String.fromInt) (years |> List.map String.fromInt)) (msg << Year << (Maybe.withDefault defaultYear << String.toInt)))
                     , inputField
                        (inputLabel "Month")
                        (Select (generateOptions ((date |> DateTime.getMonth) |> monthToInt |> String.fromInt) (months |> List.map String.fromInt)) (msg << Month << (Maybe.withDefault defaultMonth << String.toInt)))
                     , inputField
                        (inputLabel "Day")
                        (Select (generateOptions ((date |> DateTime.getDay) |> String.fromInt) (days |> List.map String.fromInt)) (msg << Day << (Maybe.withDefault defaultDay << String.toInt)))
                     ]
                        |> List.map buildInput
                        |> List.map (\e -> fi [ grow ] [ e ])
                        |> List.intersperse (fi [ blockWithWidth Constants.medium ] [])
                    )


{-| -}
buildInput : FullInputType msg -> NodeWithStyle msg
buildInput object =
    case object.value of
        Text val msg ->
            buildInputText object.commonParams val msg

        Email val msg ->
            buildInputEmail object.commonParams val msg

        TextArea val msg ->
            buildTextArea object.commonParams val msg

        Date val between msg ->
            buildDate object.commonParams val between msg

        Password val msg ->
            buildInputPassword object.commonParams val msg

        Select list msg ->
            buildSelect object.commonParams list msg

        Int val msg ->
            buildInputNumber object.commonParams val msg

        Bool val msg ->
            buildCheckbox object.commonParams val msg

        File id msg ->
            buildInputFile object.commonParams id msg


{-| -}
type alias FullInputType msg =
    { value : InputType msg
    , commonParams : CommonParams
    }


{-| -}
type alias CommonParams =
    { label : String
    , placeholder : Maybe String
    , error : Maybe String
    }


{-| -}
type InputType msg
    = Text String (String -> msg)
    | Email String (String -> msg)
    | TextArea String (String -> msg)
    | Password String (String -> msg)
    | Date (Maybe DateTime.DateTime) DateBetween (DateMsg -> msg)
    | Select (List Option) (String -> msg)
    | Int Int (Int -> msg)
    | Bool Bool (Bool -> msg)
    | File String msg


type DateBetween
    = DateBetween DateTime.DateTime DateTime.DateTime


{-| -}
type DateMsg
    = Day Int
    | Month Int
    | Year Int
    | SetDefaultDate
    | RemoveDate


{-| -}
inputField : CommonParams -> InputType msg -> FullInputType msg
inputField commonParams value =
    { commonParams = commonParams, value = value }


{-| -}
type alias InputNumberContent msg =
    { label : String
    , value : Int
    , msg : Int -> msg
    }


{-| -}
type alias InputCheckboxContent msg =
    { label : String
    , msg : Bool -> msg
    , checked : Bool
    }


{-| -}
type alias InputTextContent msg =
    { label : String
    , placeholder : String
    , value : String
    , msg : String -> msg
    }


{-| -}
inputLabel : String -> CommonParams
inputLabel labelVal =
    { label = labelVal
    , placeholder = Nothing
    , error = Nothing
    }


{-| -}
inputLabelPlaceholder : String -> String -> CommonParams
inputLabelPlaceholder labelVal placeholder =
    { label = labelVal
    , placeholder = Just placeholder
    , error = Nothing
    }


{-| -}
inputLabelPlaceholderWithError : String -> String -> Maybe String -> CommonParams
inputLabelPlaceholderWithError labelVal placeholder error =
    { label = labelVal
    , placeholder = Just placeholder
    , error = error
    }


{-| -}
inputLabelWithError : String -> Maybe String -> CommonParams
inputLabelWithError labelVal error =
    { label = labelVal
    , placeholder = Nothing
    , error = error
    }


type alias Option =
    { id : String
    , value : String
    , active : Bool
    }


{-| -}
generateOptions : String -> List String -> List Option
generateOptions activeText =
    List.map (\e -> { id = e, value = e, active = e == activeText })


{-| -}
errorMessage : String -> NodeWithStyle msg
errorMessage err =
    B.div
        [ A.style
            [ Style.box
                [ Box.textColor (Color.rgb 126 14 1)
                , typoSize 14
                ]
            ]
        ]
        [ B.text err ]


{-| -}
inputSurround : Maybe String -> String -> NodeWithStyle msg -> NodeWithStyle msg
inputSurround error label content =
    B.node
        [ A.style
            [ Style.block []
            , Style.box [ Box.paddingBottom Constants.medium ]
            ]
        ]
        [ B.div
            [ A.style
                [ Style.box
                    [ typoSize 14
                    , Box.paddingVertical (px 6)
                    , Box.paddingHorizontal (px 2)
                    ]
                ]
            ]
            [ B.text label ]
        , content
        , maybeError error
        ]


{-| -}
checkBoxSurround : String -> Bool -> (Bool -> msg) -> NodeWithStyle msg
checkBoxSurround label value msg =
    B.node
        [ A.style
            [ Style.block []
            , Style.box [ Box.paddingAll (px 12) ]
            ]
        ]
        [ B.inputCheckbox
            [ E.onCheck msg
            , A.checked value
            ]
        , B.node
            [ E.onClick (msg (not value))
            , A.style
                [ Style.box
                    [ typoSize 14
                    , Box.paddingVertical (px 6)
                    , Box.paddingHorizontal (px 2)
                    , Box.cursor Cursor.pointer
                    ]
                ]
            ]
            [ B.text label ]
        ]


{-| -}
buildInputNumber : CommonParams -> Int -> (Int -> msg) -> NodeWithStyle msg
buildInputNumber { label, error, placeholder } value msg =
    inputSurround error label <|
        B.inputNumber
            [ A.style
                [ Style.box
                    [ Box.borderColor borderColor
                    , Box.borderSolid
                    , Box.borderWidth 1
                    , Box.cornerRadius 5
                    , Box.paddingAll (px 3)
                    , typoSize 17
                    ]
                ]
            , A.value value
            , E.onInput msg
            ]


{-| -}
buildCheckbox : CommonParams -> Bool -> (Bool -> msg) -> NodeWithStyle msg
buildCheckbox { label, placeholder } =
    checkBoxSurround label


maybeError error =
    error
        |> Maybe.map errorMessage
        |> Maybe.withDefault B.none


{-| -}
labelizedInput :
    (Modifiers
        (A.BoxContainer
            { a
                | block :
                    Maybe (List ( Modifiers Display.BlockDetails, A.StyleSelector ))
                , fromStringInput : String -> String
                , onInputEvent : Maybe (String -> msg)
                , placeholder : Maybe String
                , value : Maybe String
            }
        )
     -> NodeWithStyle msg
    )
    -> CommonParams
    -> String
    -> (String -> msg)
    -> NodeWithStyle msg
labelizedInput inputFunction { label, placeholder, error } value msg =
    inputSurround error label <|
        B.div []
            [ inputFunction
                ([ inputTextStyle
                 , A.value value
                 , E.onInput msg
                 ]
                    ++ (case placeholder of
                            Just properPlaceholder ->
                                [ A.placeholder properPlaceholder ]

                            Nothing ->
                                []
                       )
                )
            ]


{-| -}
buildInputText : CommonParams -> String -> (String -> msg) -> NodeWithStyle msg
buildInputText =
    labelizedInput B.inputText


{-| -}
buildInputEmail : CommonParams -> String -> (String -> msg) -> NodeWithStyle msg
buildInputEmail =
    labelizedInput B.inputEmail


{-| -}
buildInputPassword : CommonParams -> String -> (String -> msg) -> NodeWithStyle msg
buildInputPassword =
    labelizedInput B.inputPassword


{-| -}
buildTextArea : CommonParams -> String -> (String -> msg) -> NodeWithStyle msg
buildTextArea =
    labelizedInput B.textarea


{-| -}
buildInputFile : CommonParams -> String -> msg -> NodeWithStyle msg
buildInputFile { label, error } inputFileId msg =
    inputSurround error label <|
        B.inputFile
            [ A.id inputFileId
            , E.on "change" (Decode.succeed msg)
            ]


{-| -}
buildSelect : CommonParams -> List { a | active : Bool, id : String, value : String } -> (String -> msg) -> NodeWithStyle msg
buildSelect { label, error } options msg =
    inputSurround error label <|
        B.select
            [ A.style
                [ Style.box
                    [ Box.paddingAll (px 3)
                    , Box.typography
                        [ Typography.size (px 14) ]
                    , Box.border
                        [ Border.all
                            [ Border.solid
                            , Border.color Color.black
                            , Border.thickness (px 1)
                            ]
                        ]
                    , Box.backgroundColor Color.white
                    ]
                , Style.block [ Block.fullWidth ]
                ]
            , E.onInput msg
            ]
            (options |> List.map (\e -> B.option e.id e.value e.active))


{-| -}
inputTextStyle : Modifiers.Modifier (A.BoxContainer { a | block : Maybe (List ( Modifiers.Modifiers Display.BlockDetails, A.StyleSelector )) })
inputTextStyle =
    A.style
        [ Style.box
            [ Box.borderWidth 1
            , Box.borderColor Color.black
            , Box.borderSolid
            , Box.paddingAll Constants.medium
            , typoSize 17
            ]
        , Style.block [ Block.width (percent 100) ]
        , [ Box.typography
                [ Typography.color Color.white
                , Typography.size (px 48)
                ]
          ]
            |> Style.box
            |> Style.pseudoClass "placeholder"
        ]
