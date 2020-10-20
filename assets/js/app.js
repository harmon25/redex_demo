import "../css/app.scss";
import { render } from "react-dom";
import { Socket } from "phoenix";
import { App } from "./components/App";

import { Redex } from "./redex";
import { RedexProvider } from "./redex-hooks";


const root = document.getElementById("react-root");
const username = root.dataset["user"];

const defaultState = {counter: 0}

const redex = new Redex({Socket, token: username, defaultState})

window.REDEX = redex

render(
  <RedexProvider redex={redex}>
    <App username={username} />
  </RedexProvider>,
  root
);
