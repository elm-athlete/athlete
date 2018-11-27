module DateTime exposing
    ( DateBetween(..)
    , DateMsg(..)
    , MyDate
    , monthToString
    , myDateToIso8601
    , posixToMyDate
    )

import Time exposing (Month, Posix)


type DateMsg
    = Day Int
    | Month Int
    | Year Int
    | SetDefaultDate
    | RemoveDate


type alias MyDate =
    { day : Int
    , month : Int
    , year : Int
    }


type DateBetween
    = DateBetween MyDate MyDate


{-| Return month as integer. Jan = 1 to Dec = 12.
-}
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


posixToMyDate posix =
    { year = posix |> Time.toYear Time.utc
    , month = posix |> Time.toMonth Time.utc |> monthToInt
    , day = posix |> Time.toDay Time.utc
    }


monthToString =
    monthToInt >> addZeroForUnits


addZeroForUnits : Int -> String
addZeroForUnits value =
    if value < 10 && value > -1 then
        "0" ++ String.fromInt value

    else
        String.fromInt value


myDateToIso8601 : MyDate -> String
myDateToIso8601 { day, month, year } =
    String.join "T"
        [ String.join "-"
            [ String.fromInt year
            , addZeroForUnits month
            , addZeroForUnits day
            ]
        , "00:00:00.000" ++ "Z"
        ]
