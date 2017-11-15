🚨🚨THIS IS EXPERIMENTAL.🚨🚨

We are trying to make this package reliable, and for all we know it is, but we haven't used it nearly enough to know for sure. Use are your own risk. If you do discover problems please let us know, it would be really useful.

# Elegant + BodyBuilder

Elm library to write type safe html (BodyBuilder), with inline styles compiled to CSS (Elegant) under the hood. You can find an example [here](https://elm-bodybuilder.github.io/elegant/).

# Why should I use Elegant + Bodybuilder, and how it compares to elm-css ?

Elegant takes the approach of removing on purpose the css abstraction from the developer, but it uses css under the hood to style elements.

When I create a bodybuilder div with the style `textCenter`, bodybuilder goes all over the bodybuilder tree and get all the styles, and then compiles them into a single style node on top of the generated html with the class `.text-center` with the value `text-align: center;`. In the resulting html, we then have `<div class="text-center"></div>`.

The css is totally dynamic, and is only here to style the generated html.

We could say it's a virtual css object model. We don't write css, we only write inline style, and for performance and capabilities of css, we use css.

🚨 If you are looking for an abstraction over css, look at elm-css, they do it very well.

For us, css is an abstraction of the past, and we don't need it anymore.

BodyBuilder is also an abstraction over elm-html that makes html creation Type Safe.

What we mean by that is that if you write something like `h1 [href "https://google.com"] [text "google"]`, it doesn't compile, because h1 is not a `a` element.

BodyBuilder also prevent html mistakes, like putting `button` inside `a`.

But the most impressive thing of BodyBuilder is that it allows the use of elegant.

Look at the demo folder for more impressive elegant and bodybuilder demos.

# How ?

```elm
import BodyBuilder exposing (..)
import Elegant exposing (textCenter)


view model =
    div [ style [ textCenter ] ] [ text "I'm Elegantly styled by css, but my style is set inline" ]


main : Program Basics.Never number msg
main =
    program
        { init = ( 0, Cmd.none )
        , update = (\msg model -> ( model, Cmd.none ))
        , subscriptions = always Sub.none
        , view = view
        }

```

# Next steps

Implement these things in Elegant + Bodybuilder
https://www.w3schools.com/howto/tryhow_css_parallax_demo.htm
https://codepen.io/joeaugie/pen/RWbPzo

# API Documentation

Documentation can be found [here](elm-docs).
