import './main.css'
import { Elm } from './Main.elm'
import nodes from './nodes.json'
Elm.Main.init({
  node: document.getElementById('root'),
  flags: {
    nodes
  }
})
