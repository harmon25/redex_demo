// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import { Socket } from "phoenix";
import "../css/app.scss";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
// import "phoenix_html"

import { render } from "react-dom";
import { App } from "./components/App";
import { RedexProvider } from "./RedexContext";
import { Redex } from "./redex";

const root = document.getElementById("react-root");
const username = root.dataset["user"];

let redex = new Redex({Socket, token: username})

window.REDEX = redex

render(
  <RedexProvider redex={redex}>
    <App username={username} />
  </RedexProvider>,
  root
);
