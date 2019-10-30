# `elm-html-css-builder` aka athlete

Type-safe CSS in elm is great, but it doesn't prevent a lot of invalid HTML
trees. For example, if you add width to a span, it won't have any effect. But
adding type-safety to CSS has no context of which HTML element you are in, so
it can't prevent you from expressing that.

Similarly for flex-box, since a type-safe CSS library doesn't have context on
what the parent-child relationships need to be so it can't enforce that the
parent and children are set with the appropriate flex attributes.
But athlete can!

No more changing properties and then checking the browser to see if anything changed!
athlete will give you compiler errors if you try to write CSS
that wouldn't end up having an effect, so it eliminates a whole class of impossible states!

In other words, you won't have to look through your browser dev tools for messages like this anymore!

[Tweet](https://twitter.com/patrickbrosset/status/1118889616952766466)
