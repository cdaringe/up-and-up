module Main exposing (Model, Msg(..), init, main, update, view)

import Array exposing (Array)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Node exposing (..)



---- MODEL ----


type alias Model =
    { nodes : Array Node
    }


type alias Flags =
    { nodes : Array Node
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { nodes = flags.nodes
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


render_intro =
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


render_node node =
    let
        { options, text } =
            node
    in
    div [ class "node__container" ]
        [ div
            [ class "node__content" ]
            (List.concat
                [ [ h1 [] [ Html.text text ] ]
                , List.map
                    (\link ->
                        div []
                            [ button [ onClick NoOp ] [ Html.text link.text ]
                            ]
                    )
                    options
                ]
            )
        ]


render_nodes nodes =
    let
        fragments =
            Array.map render_node nodes
    in
    Array.toList fragments


view : Model -> Html.Html Msg
view model =
    div []
        (List.concat
            [ render_intro
            , render_nodes model.nodes
            ]
        )



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Browser.element
        { view = view
        , init = \flags -> init flags
        , update = update
        , subscriptions = always Sub.none
        }
