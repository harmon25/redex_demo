export const Login = () => {
  return (
    <form method="post">
      <input
        readOnly
        hidden={true}
        name="_csrf_token"
        value={document.getElementsByTagName("meta")["csrf"].content}
      />
      <input type="text" id="username" name="username" placeholder="Username" />{" "}
      <br />
      <button type="submit"> Login</button>
    </form>
  );
};
