# DEPRECATED

This package now uses native code in its new version to ensure lightning fast performance! Try to use [the latest version published directly on GitHub](https://github.com/elm-bodybuilder/elegant)! It's way better, better typed checked, including a full featured router for your applications, and continually improved!

# Table of Contents

- [What is Elegant and BodyBuilder?](#what-is-elegant-and-bodybuilder)
- [What differences with Elm CSS and HTML?](#what-differences-with-elm-css-and-html)
- [It's awesome! How can I get it?](#its-awesome-how-can-i-get-it)
- [I need help! Can you help me?](#i-need-help-can-you-help-me)
- [It's the best package I've ever used! What can I do to help you?](#its-the-best-package-ive-ever-used-what-can-i-do-to-help-you)

# What is Elegant and BodyBuilder?

Elegant provides a safe way to write style on HTML elements without having to worry dealing with CSS. It allows you to write inline styling directly on elements. Those styles are computed, and converted into CSS under the hood, allowing to enjoy the full power of CSS without dealing with its inherent problems (cascading for example).<br>
BodyBuilder provides an abstract, type-safe way to write web applications! It abstracts HTML to facilitates the use of inline styles, type checks the attributes, and deals with HTML for you!

# What differences with Elm CSS and HTML?

Elegant and BodyBuilder take another approach: while Elm CSS provides nice way to write CSS directly in Elm to add it into your project, Elegant removes entirely CSS! The whole package uses inline styling for everything, while maintaining a `VirtualCss` handling all dirty CSS details for you. Just focus on your needs, write your application, write your styles and you're done! Elegant takes care of the styles for you! By abstracting HTML, BodyBuilder allows you to focus on your application, without having to worry on all the HTML details.

If you are looking for an abstraction over CSS, look at [`rtfeldman/elm-css`](http://package.elm-lang.org/packages/rtfeldman/elm-css/latest). This is exactly what you are looking for.

# It's awesome! How can I get it?

It's easy as pie to get your version! Just use [`panosoft/elm-grove`](https://github.com/panosoft/elm-grove) or [`gdotdesign/elm-install`](https://github.com/gdotdesign/elm-github-install)!<br>
But you can also clone [`elm-bodybuilder/elegant-template`](https://github.com/elm-bodybuilder/elegant-template) to get started right away!

# I need help! Can you help me?

Don't worry, we're on [Slack](https://elmlang.herokuapp.com/)! And we have a dedicated channel `#bodybuilder` just for this! We would be so happy to help you and to see you join us! Just come say hi!<br>
You should check [the official repo too](https://github.com/elm-bodybuilder/elegant). There are at least 10 examples to help you understand how it works! And [the documentation](https://github.com/elm-bodybuilder/elegant/tree/master/elm-docs) is on the repo too!

# It's the best package I've ever used! What can I do to help?

First, thanks!

If you want to help us, you can do plenty of things: we need documentation, tutorials, help for newcomers, detailed examples, and even performance improvements! Feel free to send us a Pull Request, to help newcomers on Slack, to improve [documentation](https://github.com/elm-bodybuilder/elegant/tree/master/elm-docs) and to post [issues](https://github.com/elm-bodybuilder/elegant/issues)!
