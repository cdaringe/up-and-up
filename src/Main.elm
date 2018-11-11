module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html.Html Msg
view model =
    div []
        [ header []
            [ img [ src "/bike.gif" ] []
            , h1 [] [ text "Up n' Up™" ]
            , h4 [] [ text "let's go biking!" ]
            ]
        , div [ class "wut info" ]
            [ h1 [] [ text "what is it." ]
            , p [] [ text "you. me. us.  biking!" ]
            , p [] [ text "let's ride bikes at lunch." ]
            ]
        , div [ class "when info" ]
            [ h1 [] [ text "when is it." ]
            , p [] [ text "wednesdays! noon. fair weather only." ]
            ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
