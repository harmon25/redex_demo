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

export const App = ({username}) => {
  return (
    <div>
      HI FROM REACT {username}
      <LogoutButton />
    </div>
  );
};
