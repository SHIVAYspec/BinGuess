module Main exposing (..)

import Browser
import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Pages.Menu as Menu


view : Menu.State -> Html Menu.Actions
view state =
    div
        [ style "background-color" "#A9DFBF"
        , style "height" "100vh"
        , style "width" "100vw"
        , style "display" "flex"
        , style "justify-content" "center"
        , style "align-items" "center"
        , style "gap" "12px"
        ]
        [ Menu.view state ]


main : Program () Menu.State Menu.Actions
main =
    Browser.sandbox { init = Menu.init, update = Menu.update, view = view }
