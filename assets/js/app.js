import "../css/app.scss";
import { render } from "react-dom";
import { Socket } from "phoenix";
import { App } from "./components/App";

import { Redex } from "./redex";
import { RedexProvider } from "./redex-hooks";

const root = document.getElementById("react-root");
const username = root.dataset["user"];

// create onReady callback that is invoked once socket + channel is connected 
function onReady(redexInstance) {
  render(
    <RedexProvider redex={redexInstance}>
      <App username={username} />
    </RedexProvider>,
    root
  );
}

// wait till Redex is ready
const redex = new Redex({
  Socket,
  token: username,
  onReady,
});

window.REDEX = redex;
