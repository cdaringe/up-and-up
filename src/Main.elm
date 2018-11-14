module Main exposing (Model, Msg(..), init, main, update, view)

import Array exposing (Array)
import Browser
import Browser.Dom as Dom
import Html exposing (button, div, h1, h4, header, img, p, text)
import Html.Attributes exposing (class, id, src, style)
import Html.Events exposing (onClick)
import List exposing (..)
import Node exposing (..)
import Task



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
    | ScrollToPane String


scrollToPane id =
    Dom.getElement id
        |> Task.andThen (\el -> Dom.setViewport el.element.x el.element.y)
        |> Task.onError (\_ -> Task.succeed ())
        |> Task.perform (\_ -> NoOp)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ScrollToPane id ->
            ( model, scrollToPane id )



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
        { key, options, text } =
            node
    in
    div [ id key, class "node__container" ]
        [ div
            [ class "node__content" ]
          <|
            concat
                [ [ h1 [] [ Html.text text ] ]
                , map
                    (\link ->
                        div []
                            [ button [ onClick <| ScrollToPane link.to ] [ Html.text link.text ]
                            ]
                    )
                    options
                ]
        ]


render_nodes nodes =
    let
        fragments =
            Array.map render_node nodes
    in
    Array.toList fragments


view : Model -> Html.Html Msg
view model =
    div [] <|
        concat
            [ render_intro
            , render_nodes model.nodes
            ]



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Browser.element
        { view = view
        , init = \flags -> init flags
        , update = update
        , subscriptions = always Sub.none
        }
