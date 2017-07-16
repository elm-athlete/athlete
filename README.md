🚨🚨THIS IS EXPERIMENTAL.🚨🚨

We are trying to make this package reliable, and for all we know it is, but we haven't used it nearly enough to know for sure. Use are your own risk. If you do discover problems please let us know, it would be really useful.

# Elegant + BodyBuilder

Elm library to write type safe html (BodyBuilder), with inline styles compiled to CSS (Elegant) under the hood. You can find an example [here](https://elm-bodybuilder.github.io/elegant/).

```elm
import BodyBuilder exposing (..)
import Elegant exposing (textCenter)

view =
  div [style [textCenter]] [text "I'm Elegantly styled by css, but my style is set inline"]

main : Program Basics.Never model msg
main =
    program
        { init = (0, Cmd.none)
        , update = (\msg m -> m)
        , subscriptions = always Sub.none
        , view = view
        }
```
