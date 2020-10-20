import { useState } from "react";
import { useRedexState, useRedexDispatch } from "../redex-hooks";

const LogoutButton = () => {
  return (
    <form action="/logout" method="post">
      <input
        hidden={true}
        readOnly
        name="_csrf_token"
        value={document.getElementsByTagName("meta")["csrf"].content}
      />
      <button type="submit"> Logout </button>
    </form>
  );
};

const Counter = () => {
  const [state] = useRedexState((state) => state.counter);
  return (
    <div>
      <strong> {state}</strong>
    </div>
  );
};

const Counter2 = () => {
  const [state] = useRedexState();
  return (
    <div>
      <strong> {JSON.stringify(state)}</strong>
    </div>
  );
};

export const App = ({ username }) => {
  const dispatch = useRedexDispatch();
  const [hidden, setHidden] = useState(false);

  const handleHideClick = () => {
    setHidden((hidden) => !hidden)
  };
  return (
    <div>
      <span
        onClick={() => {
          dispatch({ type: "add", payload: 10 });
        }}
      >
        HI FROM REACT {username}{" "}
      </span>
      <button onClick={handleHideClick}> {hidden ? "UNHIDE" : "HIDE"} </button>
      {!hidden ? (
        <div>
          <Counter />
          <Counter2 />
        </div>
      ) : null}
      <LogoutButton />
    </div>
  );
};
