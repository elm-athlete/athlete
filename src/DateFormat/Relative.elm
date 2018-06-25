module DateFormat.Relative
    exposing
        ( RelativeTimeOptions
        , relativeTime
        , relativeTimeWithOptions
        )

{-| A reliable way to get a pretty message for the relative time difference between two dates.


# Getting relative time for two dates

@docs relativeTime, relativeTimeWithOptions, RelativeTimeOptions

-}

import Time exposing (Month(..), Posix, Weekday(..), Zone, utc)


{-| This function takes in two times and returns the relative difference!

Here are a few examples to help:

    relativeTime now tenSecondsAgo ==  "just now"
    relativeTime now tenSecondsFromNow ==  "in a few seconds"

    relativeTime now fortyThreeMinutesAgo == "43 minutes ago"

    relativeTime now oneHundredDaysAgo == "100 days ago"
    relativeTime now oneHundredDaysFromNow == "in 100 days"

    -- Order matters!
    relativeTime now tenSecondsAgo ==  "just now"
    relativeTime tenSecondsAgo now ==  "in a few seconds"

-}
relativeTime : Posix -> Posix -> String
relativeTime =
    relativeTimeWithOptions defaultRelativeOptions


{-| Maybe `relativeTime` is too lame. (Or maybe you speak a different language than English!)

With `relativeTimeWithOptions`, you can provide your own custom messages for each time range.

(That's what `relativeTime` uses under the hood!)

You can provide a set of your own custom options, and use `relativeTimeWithOptions` instead.

-}
relativeTimeWithOptions : RelativeTimeOptions -> Posix -> Posix -> String
relativeTimeWithOptions options start end =
    let
        differenceInMilliseconds : Int
        differenceInMilliseconds =
            toMilliseconds end - toMilliseconds start

        time : Posix
        time =
            Time.millisToPosix (abs differenceInMilliseconds)
    in
    if differenceInMilliseconds == 0 then
        options.rightNow
    else
        relativeTimeWithFunctions utc time <|
            if differenceInMilliseconds < 0 then
                RelativeTimeFunctions
                    options.someSecondsAgo
                    options.someMinutesAgo
                    options.someHoursAgo
                    options.someDaysAgo
                    options.someMonthsAgo
                    options.someYearsAgo
            else
                RelativeTimeFunctions
                    options.inSomeSeconds
                    options.inSomeMinutes
                    options.inSomeHours
                    options.inSomeDays
                    options.inSomeMonths
                    options.inSomeYears


{-| Options for configuring your own relative message formats!

For example, here is how `someSecondsAgo` is implemented by default:

    defaultSomeSecondsAgo : Int -> String
    defaultSomeSecondsAgo seconds =
        if seconds < 30 then
            "just now"
        else
            toString seconds ++ " seconds ago"

And here is how `inSomeHours` might look:

    defaultInSomeHours : Int -> String
    defaultInSomeHours hours =
        if hours < 2 then
            "in an hour"
        else
            "in " ++ toString hours ++ " hours"

-}
type alias RelativeTimeOptions =
    { someSecondsAgo : Int -> String
    , someMinutesAgo : Int -> String
    , someHoursAgo : Int -> String
    , someDaysAgo : Int -> String
    , someMonthsAgo : Int -> String
    , someYearsAgo : Int -> String
    , rightNow : String
    , inSomeSeconds : Int -> String
    , inSomeMinutes : Int -> String
    , inSomeHours : Int -> String
    , inSomeDays : Int -> String
    , inSomeMonths : Int -> String
    , inSomeYears : Int -> String
    }


defaultRelativeOptions : RelativeTimeOptions
defaultRelativeOptions =
    { someSecondsAgo = defaultSomeSecondsAgo
    , someMinutesAgo = defaultSomeMinutesAgo
    , someHoursAgo = defaultSomeHoursAgo
    , someDaysAgo = defaultSomeDaysAgo
    , someMonthsAgo = defaultSomeMonthsAgo
    , someYearsAgo = defaultSomeYearsAgo
    , rightNow = defaultRightNow
    , inSomeSeconds = defaultInSomeSeconds
    , inSomeMinutes = defaultInSomeMinutes
    , inSomeHours = defaultInSomeHours
    , inSomeDays = defaultInSomeDays
    , inSomeMonths = defaultInSomeMonths
    , inSomeYears = defaultInSomeYears
    }


toMilliseconds : Posix -> Int
toMilliseconds =
    Time.posixToMillis


type alias RelativeTimeFunctions =
    { seconds : Int -> String
    , minutes : Int -> String
    , hours : Int -> String
    , days : Int -> String
    , months : Int -> String
    , years : Int -> String
    }


relativeTimeWithFunctions : Zone -> Posix -> RelativeTimeFunctions -> String
relativeTimeWithFunctions zone posix functions =
    if Time.toMinute zone posix < 1 then
        functions.seconds <| Time.toSecond zone posix
    else if Time.toHour zone posix < 1 then
        functions.minutes <| Time.toMinute zone posix
    else if Time.toHour zone posix < 24 then
        functions.hours <| Time.toHour zone posix
    else if Time.toHour zone posix < 24 * 30 then
        functions.days <| (Time.toHour zone posix // 24)
    else if Time.toHour zone posix < 24 * 365 then
        functions.months <| (Time.toHour zone posix // 24 // 12)
    else
        functions.years <| (Time.toHour zone posix // 24 // 365)


defaultRightNow : String
defaultRightNow =
    "right now"


defaultSomeSecondsAgo : Int -> String
defaultSomeSecondsAgo seconds =
    if seconds < 30 then
        "just now"
    else
        String.fromInt seconds ++ " seconds ago"


defaultSomeMinutesAgo : Int -> String
defaultSomeMinutesAgo minutes =
    if minutes < 2 then
        "a minute ago"
    else
        String.fromInt minutes ++ " minutes ago"


defaultSomeHoursAgo : Int -> String
defaultSomeHoursAgo hours =
    if hours < 2 then
        "an hour ago"
    else
        String.fromInt hours ++ " hours ago"


defaultSomeDaysAgo : Int -> String
defaultSomeDaysAgo days =
    if days < 2 then
        "yesterday"
    else
        String.fromInt days ++ " days ago"


defaultSomeMonthsAgo : Int -> String
defaultSomeMonthsAgo months =
    if months < 2 then
        "last month"
    else
        String.fromInt months ++ " months ago"


defaultSomeYearsAgo : Int -> String
defaultSomeYearsAgo years =
    if years < 2 then
        "last year"
    else
        String.fromInt years ++ " years ago"


defaultInSomeSeconds : Int -> String
defaultInSomeSeconds seconds =
    if seconds < 30 then
        "in a few seconds"
    else
        "in " ++ String.fromInt seconds ++ " seconds"


defaultInSomeMinutes : Int -> String
defaultInSomeMinutes minutes =
    if minutes < 2 then
        "in a minute"
    else
        "in " ++ String.fromInt minutes ++ " minutes"


defaultInSomeHours : Int -> String
defaultInSomeHours hours =
    if hours < 2 then
        "in an hour"
    else
        "in " ++ String.fromInt hours ++ " hours"


defaultInSomeDays : Int -> String
defaultInSomeDays days =
    if days < 2 then
        "tomorrow"
    else
        "in " ++ String.fromInt days ++ " days"


defaultInSomeMonths : Int -> String
defaultInSomeMonths months =
    if months < 2 then
        "in a month"
    else
        "in " ++ String.fromInt months ++ " months"


defaultInSomeYears : Int -> String
defaultInSomeYears years =
    if years < 2 then
        "in a year"
    else
        "in " ++ String.fromInt years ++ " years"
