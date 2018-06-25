module DateFormat
    exposing
        ( FormatOptions
        , Token
        , amPmLowercase
        , amPmUppercase
        , dayOfMonthFixed
        , dayOfMonthNumber
        , dayOfMonthSuffix
        , dayOfWeekNameFirstThree
        , dayOfWeekNameFirstTwo
        , dayOfWeekNameFull
        , dayOfWeekNumber
        , dayOfWeekSuffix
        , dayOfYearFixed
        , dayOfYearNumber
        , dayOfYearSuffix
        , format
        , formatWithOptions
        , hourFixed
        , hourMilitaryFixed
        , hourMilitaryFromOneFixed
        , hourMilitaryFromOneNumber
        , hourMilitaryNumber
        , hourNumber
        , minuteFixed
        , minuteNumber
        , monthFixed
        , monthNameFirstThree
        , monthNameFull
        , monthNumber
        , monthSuffix
        , quarterNumber
        , quarterSuffix
        , secondFixed
        , secondNumber
        , text
        , weekOfYearFixed
        , weekOfYearNumber
        , weekOfYearSuffix
        , yearNumber
        , yearNumberLastTwo
        )

{-| A reliable way to format dates and times with Elm.


# Formatting dates

@docs format


# Supporting a different language?

@docs formatWithOptions, FormatOptions


# Available formatting options

@docs Token


## Month

@docs monthNumber, monthSuffix, monthFixed, monthNameFirstThree, monthNameFull


## Day of the Month

@docs dayOfMonthNumber, dayOfMonthSuffix, dayOfMonthFixed


## Day of the Year

@docs dayOfYearNumber, dayOfYearSuffix, dayOfYearFixed


## Day of the Week

@docs dayOfWeekNumber, dayOfWeekSuffix, dayOfWeekNameFirstTwo, dayOfWeekNameFirstThree, dayOfWeekNameFull


## Year

@docs yearNumberLastTwo, yearNumber


## Quarter of the Year

@docs quarterNumber, quarterSuffix


## Week of the Year

@docs weekOfYearNumber, weekOfYearSuffix, weekOfYearFixed


## AM / PM

@docs amPmUppercase, amPmLowercase


## Hour

@docs hourMilitaryNumber, hourMilitaryFixed, hourNumber, hourFixed, hourMilitaryFromOneNumber, hourMilitaryFromOneFixed


## Minute

@docs minuteNumber, minuteFixed


## Second

@docs secondNumber, secondFixed


## Other Stuff

@docs text

-}

import Time
    exposing
        ( Month(..)
        , Posix
        , Weekday(..)
        , Zone
        )


{-| Get the numeric value of the month.

Examples: `1, 2, 3, ... 11, 12`

-}
monthNumber : Token
monthNumber =
    MonthNumber


{-| Get the numeric value of the month, with a suffix at the end.

Examples: `1st, 2nd, 3rd, ... 11th, 12th`

-}
monthSuffix : Token
monthSuffix =
    MonthSuffix


{-| Get the numeric value of the month, fixed to two places.

Examples: `01, 02, 03, ... 11, 12`

-}
monthFixed : Token
monthFixed =
    MonthFixed


{-| Get the name of the month, but just the first three letters.

Examples: `Jan, Feb, Mar, ... Nov, Dec`

-}
monthNameFirstThree : Token
monthNameFirstThree =
    MonthNameFirst 3


{-| Get the full name of the month.

Examples: `January, February, ... December`

-}
monthNameFull : Token
monthNameFull =
    MonthNameFull


{-| Get the numeric value of the day of the month.

Examples: `1, 2, 3, ... 30, 31`

-}
dayOfMonthNumber : Token
dayOfMonthNumber =
    DayOfMonthNumber


{-| Get the numeric value of the day of the month, with a suffix at the end.

Examples: `1st, 2nd, 3rd, ... 30th, 31st`

-}
dayOfMonthSuffix : Token
dayOfMonthSuffix =
    DayOfMonthSuffix


{-| Get the numeric value of the day of the month, fixed to two places.

Examples: `01, 02, 03, ... 30, 31`

-}
dayOfMonthFixed : Token
dayOfMonthFixed =
    DayOfMonthFixed


{-| Get the numeric value of the day of the year.

Examples: `1, 2, 3, ... 364, 365`

-}
dayOfYearNumber : Token
dayOfYearNumber =
    DayOfYearNumber


{-| Get the numeric value of the day of the year, with a suffix at the end.

Examples: `1st, 2nd, 3rd, ... 364th, 365th`

-}
dayOfYearSuffix : Token
dayOfYearSuffix =
    DayOfYearSuffix


{-| Get the numeric value of the day of the year, fixed to three places.

Examples: `001, 002, 003, ... 364, 365`

-}
dayOfYearFixed : Token
dayOfYearFixed =
    DayOfYearFixed


{-| Get the numeric value of the day of the week.

Examples: `0, 1, 2, ... 5, 6`

-}
dayOfWeekNumber : Token
dayOfWeekNumber =
    DayOfWeekNumber


{-| Get the numeric value of the day of the week, with a suffix at the end.

Examples: `0th, 1st, 2nd, ... 5th, 6th`

-}
dayOfWeekSuffix : Token
dayOfWeekSuffix =
    DayOfWeekSuffix


{-| Gets the name of the day of the week, but just the first two letters.

Examples: `Su, Mo, Tu, ... Fr, Sa`

-}
dayOfWeekNameFirstTwo : Token
dayOfWeekNameFirstTwo =
    DayOfWeekNameFirst 2


{-| Gets the name of the day of the week, but just the first three letters.

Examples: `Sun, Mon, Tue, ... Fri, Sat`

-}
dayOfWeekNameFirstThree : Token
dayOfWeekNameFirstThree =
    DayOfWeekNameFirst 3


{-| Gets the full name of the day of the week.

Examples: `Sunday, Monday, ... Friday, Saturday`

-}
dayOfWeekNameFull : Token
dayOfWeekNameFull =
    DayOfWeekNameFull


{-| Get the year, but just the last two letters.

Examples: `70, 71, ... 29, 30`

-}
yearNumberLastTwo : Token
yearNumberLastTwo =
    YearNumberLastTwo


{-| Get the year.

Examples: `1970, 1971, ... 2018, ... 9999, ...`

-}
yearNumber : Token
yearNumber =
    YearNumber


{-| Get the numeric value for the quarter of the year.

Examples: `1, 2, 3, 4`

-}
quarterNumber : Token
quarterNumber =
    QuarterNumber


{-| Get the numeric value for the quarter of the year, with a suffix.

Examples: `1st, 2nd, 3rd, 4th`

-}
quarterSuffix : Token
quarterSuffix =
    QuarterSuffix


{-| Get the numeric value for the week of the year.

Examples: `1, 2, 3, ... 51, 52`

-}
weekOfYearNumber : Token
weekOfYearNumber =
    WeekOfYearNumber


{-| Get the numeric value for the week of the year, with a suffix at the end.

Examples: `1st, 2nd, 3rd, ... 51st, 52nd`

-}
weekOfYearSuffix : Token
weekOfYearSuffix =
    WeekOfYearSuffix


{-| Get the numeric value for the week of the year, fixed to two places.

Examples: `01, 02, 03, ... 51, 52`

-}
weekOfYearFixed : Token
weekOfYearFixed =
    WeekOfYearFixed


{-| Get the AM / PM value of the hour, in uppercase.

Examples: `AM, PM`

-}
amPmUppercase : Token
amPmUppercase =
    AmPmUppercase


{-| Get the AM / PM value of the hour, in uppercase.

Examples: `am, pm`

-}
amPmLowercase : Token
amPmLowercase =
    AmPmLowercase


{-| Get the hour of the 24-hour day.

Examples: `0, 1, 2, ... 22, 23`

-}
hourMilitaryNumber : Token
hourMilitaryNumber =
    HourMilitaryNumber


{-| Get the hour of the 24-hour day, fixed to two places.

Examples: `00, 01, 02, ... 22, 23`

-}
hourMilitaryFixed : Token
hourMilitaryFixed =
    HourMilitaryFixed


{-| Get the hour of the 12-hour day.

Examples: `0, 1, 2, ... 11, 12`

-}
hourNumber : Token
hourNumber =
    HourNumber


{-| Get the hour of the 12-hour day, fixed to two places.

Examples: `00, 01, 02, ... 11, 12`

-}
hourFixed : Token
hourFixed =
    HourFixed


{-| Get the hour of the 24-hour day, starting from one.

Examples: `1, 2, ... 23, 24`

-}
hourMilitaryFromOneNumber : Token
hourMilitaryFromOneNumber =
    HourMilitaryFromOneNumber


{-| Get the hour of the 24-hour day, starting from one, fixed to two places.

Examples: `01, 02, ... 23, 24`

-}
hourMilitaryFromOneFixed : Token
hourMilitaryFromOneFixed =
    HourMilitaryFromOneFixed


{-| Get the minute of the hour.

Examples: `0, 1, 2, ... 58, 59`

-}
minuteNumber : Token
minuteNumber =
    MinuteNumber


{-| Get the minute of the hour, fixed to two places.

Examples: `00, 01, 02, ... 58, 59`

-}
minuteFixed : Token
minuteFixed =
    MinuteFixed


{-| Get the second of the minute.

Examples: `0, 1, 2, ... 58, 59`

-}
secondNumber : Token
secondNumber =
    SecondNumber


{-| Get the second of the minute, fixed to two places.

Examples: `00, 01, 02, ... 58, 59`

-}
secondFixed : Token
secondFixed =
    SecondFixed


{-| Represent a string value

    formatter : Zone -> Posix -> String
    formatter =
        DateFormat.format
            [ DateFormat.hourMilitaryFixed
            , DateFormat.text ":"
            , DateFormat.minuteFixed
            ]

When given a [`Zone`](/packages/elm-lang/time/latest/Time#Zone) and [`Posix`](/packages/elm-lang/time/latest/Time#Posix), this will return something like `"23:15"` or `"04:43"`

-}
text : String -> Token
text =
    Text


{-| These are the available tokens to help you format dates.
-}
type Token
    = MonthNumber
    | MonthSuffix
    | MonthFixed
    | MonthNameFirst Int
    | MonthNameFull
    | DayOfMonthNumber
    | DayOfMonthSuffix
    | DayOfMonthFixed
    | DayOfYearNumber
    | DayOfYearSuffix
    | DayOfYearFixed
    | DayOfWeekNumber
    | DayOfWeekSuffix
    | DayOfWeekNameFirst Int
    | DayOfWeekNameFull
    | YearNumberLastTwo
    | YearNumber
    | QuarterNumber
    | QuarterSuffix
    | WeekOfYearNumber
    | WeekOfYearSuffix
    | WeekOfYearFixed
    | AmPmUppercase
    | AmPmLowercase
    | HourMilitaryNumber
    | HourMilitaryFixed
    | HourNumber
    | HourFixed
    | HourMilitaryFromOneNumber
    | HourMilitaryFromOneFixed
    | MinuteNumber
    | MinuteFixed
    | SecondNumber
    | SecondFixed
    | Text String


{-| This function takes in a list of tokens, [`Zone`](/packages/elm-lang/time/latest/Time#Zone), and [`Posix`](/packages/elm-lang/time/latest/Time#Posix) to create your formatted string!

Let's say `ourPosixValue` is November 15, 1993 at 15:06.

    -- "15:06"
    format
        [ hourMilitaryFixed
        , text ":"
        , minuteFixed
        ]
        utc
        ourPosixValue

    -- "3:06 pm"
    format
        [ hourNumber
        , text ":"
        , minuteFixed
        , text " "
        , amPmLowercase
        ]
        utc
        ourPosixValue

    -- "Nov 15th, 1993"
    format
        [ monthNameFirstThree
        , text " "
        , dayOfMonthSuffix
        , text ", "
        , yearNumber
        ]
        utc
        ourPosixValue

-}
format : List Token -> Zone -> Posix -> String
format =
    formatWithOptions defaultOptions


{-| If our users don't speak English, printing out "Monday" or "Tuesday" might not be a great fit.

Thanks to a great recommendation, `date-format` now supports multilingual output!

All you need to do is provide your own options, and format will use your preferences instead:

For a complete example, check out the [`FormatWithOptions.elm` in the examples folder](https://github.com/ryannhg/date-format/blob/master/examples/FormatWithOptions.elm).

-}
formatWithOptions : FormatOptions -> List Token -> Zone -> Posix -> String
formatWithOptions options tokens zone time =
    tokens
        |> List.map (piece options zone time)
        |> String.join ""


{-| These are the available options for formatting our dates.

Here's an example for creating Spanish `FormatOptions`:

    spanishFullMonthName : Time.Month -> String
    spanishFullMonthName month =
        case month of
            Jan ->
                "Enero"

            Feb ->
                "Febrero"

            Mar ->
                "Marzo"

            Apr ->
                "Abril"

            May ->
                "Mayo"

            Jun ->
                "Junio"

            Jul ->
                "Julio"

            Aug ->
                "Agosto"

            Sep ->
                "Septiembre"

            Oct ->
                "Octubre"

            Nov ->
                "Noviembre"

            Dec ->
                "Diciembre"

    spanishDayOfWeekName : Time.Weekday -> String
    spanishDayOfWeekName weekday =
        case weekday of
            Mon ->
                "Lunes"

            Tue ->
                "Martes"

            Wed ->
                "Miércoles"

            Thu ->
                "Jueves"

            Fri ->
                "Viernes"

            Sat ->
                "Sábado"

            Sun ->
                "Domingo"

    spanishOptions : DateFormat.FormatOptions
    spanishOptions =
        { fullMonthName = spanishFullMonthName
        , dayOfWeekName = spanishDayOfWeekName
        }

-}
type alias FormatOptions =
    { fullMonthName : Time.Month -> String
    , dayOfWeekName : Time.Weekday -> String
    }


{-| Months of the year, in the correct order.
-}
months : List Month
months =
    [ Jan
    , Feb
    , Mar
    , Apr
    , May
    , Jun
    , Jul
    , Aug
    , Sep
    , Nov
    , Dec
    ]


{-| Days of the week, starting with Sunday.
-}
days : List Weekday
days =
    [ Sun
    , Mon
    , Tue
    , Wed
    , Thu
    , Fri
    , Sat
    ]


defaultOptions : FormatOptions
defaultOptions =
    FormatOptions
        fullMonthName
        dayOfWeekName


piece : FormatOptions -> Zone -> Posix -> Token -> String
piece options zone posix token =
    case token of
        MonthNumber ->
            monthNumber_ zone posix
                |> String.fromInt

        MonthSuffix ->
            monthNumber_ zone posix
                |> toSuffix

        MonthFixed ->
            monthNumber_ zone posix
                |> toFixedLength 2

        MonthNameFirst num ->
            options.fullMonthName (Time.toMonth zone posix)
                |> String.left num

        MonthNameFull ->
            options.fullMonthName (Time.toMonth zone posix)

        QuarterNumber ->
            quarter zone posix
                |> (+) 1
                |> String.fromInt

        QuarterSuffix ->
            quarter zone posix
                |> (+) 1
                |> toSuffix

        DayOfMonthNumber ->
            dayOfMonth zone posix
                |> String.fromInt

        DayOfMonthSuffix ->
            dayOfMonth zone posix
                |> toSuffix

        DayOfMonthFixed ->
            dayOfMonth zone posix
                |> toFixedLength 2

        DayOfYearNumber ->
            dayOfYear zone posix
                |> String.fromInt

        DayOfYearSuffix ->
            dayOfYear zone posix
                |> toSuffix

        DayOfYearFixed ->
            dayOfYear zone posix
                |> toFixedLength 3

        DayOfWeekNumber ->
            dayOfWeek zone posix
                |> String.fromInt

        DayOfWeekSuffix ->
            dayOfWeek zone posix
                |> toSuffix

        DayOfWeekNameFirst num ->
            options.dayOfWeekName (Time.toWeekday zone posix)
                |> String.left num

        DayOfWeekNameFull ->
            options.dayOfWeekName (Time.toWeekday zone posix)

        WeekOfYearNumber ->
            weekOfYear zone posix
                |> String.fromInt

        WeekOfYearSuffix ->
            weekOfYear zone posix
                |> toSuffix

        WeekOfYearFixed ->
            weekOfYear zone posix
                |> toFixedLength 2

        YearNumberLastTwo ->
            year zone posix
                |> String.right 2

        YearNumber ->
            year zone posix

        AmPmUppercase ->
            amPm zone posix
                |> String.toUpper

        AmPmLowercase ->
            amPm zone posix
                |> String.toLower

        HourMilitaryNumber ->
            Time.toHour zone posix
                |> String.fromInt

        HourMilitaryFixed ->
            Time.toHour zone posix
                |> toFixedLength 2

        HourNumber ->
            Time.toHour zone posix
                |> toNonMilitary
                |> String.fromInt

        HourFixed ->
            Time.toHour zone posix
                |> toNonMilitary
                |> toFixedLength 2

        HourMilitaryFromOneNumber ->
            Time.toHour zone posix
                |> (+) 1
                |> String.fromInt

        HourMilitaryFromOneFixed ->
            Time.toHour zone posix
                |> (+) 1
                |> toFixedLength 2

        MinuteNumber ->
            Time.toMinute zone posix
                |> String.fromInt

        MinuteFixed ->
            Time.toMinute zone posix
                |> toFixedLength 2

        SecondNumber ->
            Time.toSecond zone posix
                |> String.fromInt

        SecondFixed ->
            Time.toSecond zone posix
                |> toFixedLength 2

        Text string ->
            string



-- MONTHS


monthPair : Zone -> Posix -> ( Int, Month )
monthPair zone posix =
    months
        |> List.indexedMap (\a b -> ( a, b ))
        |> List.filter (\( i, m ) -> m == Time.toMonth zone posix)
        |> List.head
        |> Maybe.withDefault ( 0, Jan )


monthNumber_ : Zone -> Posix -> Int
monthNumber_ zone posix =
    monthPair zone posix
        |> (\( i, m ) -> i)
        |> (+) 1


fullMonthName : Month -> String
fullMonthName month =
    case month of
        Jan ->
            "January"

        Feb ->
            "February"

        Mar ->
            "March"

        Apr ->
            "April"

        May ->
            "May"

        Jun ->
            "June"

        Jul ->
            "July"

        Aug ->
            "August"

        Sep ->
            "September"

        Oct ->
            "October"

        Nov ->
            "November"

        Dec ->
            "December"


daysInMonth : Int -> Month -> Int
daysInMonth year_ month =
    case month of
        Jan ->
            31

        Feb ->
            if isLeapYear year_ then
                29

            else
                28

        Mar ->
            31

        Apr ->
            30

        May ->
            31

        Jun ->
            30

        Jul ->
            31

        Aug ->
            31

        Sep ->
            30

        Oct ->
            31

        Nov ->
            30

        Dec ->
            31


isLeapYear : Int -> Bool
isLeapYear year_ =
    if modBy 4 year_ /= 0 then
        False

    else if modBy 100 year_ /= 0 then
        True

    else if modBy 400 year_ /= 0 then
        False

    else
        True



-- QUARTERS


quarter : Zone -> Posix -> Int
quarter zone posix =
    monthNumber_ zone posix // 4



-- DAY OF MONTH


dayOfMonth : Zone -> Posix -> Int
dayOfMonth =
    Time.toDay



-- DAY OF YEAR


dayOfYear : Zone -> Posix -> Int
dayOfYear zone posix =
    let
        monthsBeforeThisOne : List Month
        monthsBeforeThisOne =
            List.take (monthNumber_ zone posix - 1) months

        daysBeforeThisMonth : Int
        daysBeforeThisMonth =
            monthsBeforeThisOne
                |> List.map (daysInMonth (Time.toYear zone posix))
                |> List.sum
    in
    daysBeforeThisMonth + dayOfMonth zone posix



-- DAY OF WEEK


dayOfWeek : Zone -> Posix -> Int
dayOfWeek zone posix =
    days
        |> List.indexedMap (\i day -> ( i, day ))
        |> List.filter (\( _, day ) -> day == Time.toWeekday zone posix)
        |> List.head
        |> Maybe.withDefault ( 0, Sun )
        |> (\( i, _ ) -> i)


dayOfWeekName : Time.Weekday -> String
dayOfWeekName weekday =
    case weekday of
        Mon ->
            "Monday"

        Tue ->
            "Tuesday"

        Wed ->
            "Wednesday"

        Thu ->
            "Thursday"

        Fri ->
            "Friday"

        Sat ->
            "Saturday"

        Sun ->
            "Sunday"



-- WEEK OF YEAR


type alias SimpleDate =
    { month : Month
    , day : Int
    , year : Int
    }


weekOfYear : Zone -> Posix -> Int
weekOfYear zone posix =
    let
        daysSoFar : Int
        daysSoFar =
            dayOfYear zone posix

        firstDay : Posix
        firstDay =
            firstDayOfYear zone posix

        firstDayOffset : Int
        firstDayOffset =
            dayOfWeek zone firstDay
    in
    (daysSoFar + firstDayOffset) // 7 + 1


millisecondsPerYear : Int
millisecondsPerYear =
    round (1000 * 60 * 60 * 24 * 365.25)


firstDayOfYear : Zone -> Posix -> Posix
firstDayOfYear zone time =
    time
        |> Time.toYear zone
        |> (*) millisecondsPerYear
        |> Time.millisToPosix



-- YEAR


year : Zone -> Posix -> String
year zone time =
    time
        |> Time.toYear zone
        |> String.fromInt



-- AM / PM


amPm : Zone -> Posix -> String
amPm zone posix =
    if Time.toHour zone posix > 11 then
        "pm"

    else
        "am"



-- HOUR


toNonMilitary : Int -> Int
toNonMilitary num =
    if num == 0 then
        12

    else if num <= 12 then
        num

    else
        num - 12



-- GENERIC


toFixedLength : Int -> Int -> String
toFixedLength totalChars num =
    let
        numStr =
            String.fromInt num

        numZerosNeeded =
            totalChars - String.length numStr

        zeros =
            List.range 1 numZerosNeeded
                |> List.map (\_ -> "0")
                |> String.join ""
    in
    zeros ++ numStr


toSuffix : Int -> String
toSuffix num =
    let
        suffix =
            case num of
                11 ->
                    "th"

                12 ->
                    "th"

                13 ->
                    "th"

                _ ->
                    case modBy 10 num of
                        1 ->
                            "st"

                        2 ->
                            "nd"

                        3 ->
                            "rd"

                        _ ->
                            "th"
    in
    String.fromInt num ++ suffix
