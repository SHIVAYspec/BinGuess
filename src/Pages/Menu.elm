module Pages.Menu exposing (Actions, State, init, update, view)

import Basics exposing (abs, ceiling, logBase, toFloat)
import Html exposing (Html, button, div, input, p, text)
import Html.Attributes exposing (placeholder, style, type_, value)
import Html.Events exposing (onClick, onInput)
import Pages.Questions as Questions


type alias MenuState =
    { lower : Int, upper : Int }


type State
    = Menu MenuState
    | Started Questions.State


initMenu : MenuState
initMenu =
    { lower = 0, upper = 1234 }


init : State
init =
    Menu initMenu


type Actions
    = SetLower String
    | SetUpper String
    | Start
    | Reset
    | Questions Questions.Actions


getOrElse : Maybe a -> a -> a
getOrElse maybeValue defaultValue =
    case maybeValue of
        Just value ->
            value

        Nothing ->
            defaultValue


getIntOrElse : String -> Int -> Int
getIntOrElse inputStr defaultValue =
    getOrElse (String.toInt inputStr) defaultValue


update : Actions -> State -> State
update actions state =
    case actions of
        SetLower e ->
            case state of
                Menu menuState ->
                    Menu
                        { menuState | lower = getIntOrElse e 0 }

                Started _ ->
                    -- Invalid
                    state

        SetUpper e ->
            case state of
                Menu menuState ->
                    Menu { menuState | upper = getIntOrElse e 0 }

                Started _ ->
                    -- Invalid
                    state

        Start ->
            case state of
                Menu e ->
                    Started
                        (if e.lower <= e.upper then
                            { lower = e.lower, upper = e.upper }

                         else
                            { lower = e.upper, upper = e.lower }
                        )

                Started _ ->
                    state

        Reset ->
            init

        Questions a ->
            case state of
                Menu _ ->
                    state

                Started s ->
                    Started (Questions.update a s)


styleSheet : List (Html.Attribute msg)
styleSheet =
    [ style "margin" "0"
    , style "font-weight" "bold"
    , style "font-size" "18px"
    , style "font-family" "monospace"
    ]


getRequiredAttempts : MenuState -> String
getRequiredAttempts menuState =
    if menuState.lower == menuState.upper then
        "1"

    else
        String.fromInt (ceiling (logBase 2 (toFloat (abs (menuState.lower - menuState.upper)))))


view : State -> Html Actions
view state =
    div [ style "margin" "12px" ]
        [ case state of
            Menu e ->
                div
                    [ style "display" "flex"
                    , style "flex-direction" "column"
                    , style "gap" "12px"
                    ]
                    [ p styleSheet [ text "Pick a number between" ]
                    , input ([ type_ "number", placeholder "Lower Limit", value (String.fromInt e.lower), onInput SetLower ] ++ styleSheet) []
                    , p styleSheet [ text "and" ]
                    , input ([ type_ "number", placeholder "Upper Limit", value (String.fromInt e.upper), onInput SetUpper ] ++ styleSheet) []
                    , p styleSheet [ text ("I will guess it in " ++ getRequiredAttempts e ++ " attempts or less.") ]
                    , button (styleSheet ++ [ onClick Start ]) [ text "Start" ]
                    ]

            Started e ->
                Html.map Questions (Questions.view e)
        , case state of
            Menu _ ->
                text ""

            Started _ ->
                button [ onClick Reset ] [ text "reset" ]
        ]
