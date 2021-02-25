<!DOCTYPE html>
<html>
<head>
  <title>Tournament Arc - Login</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="./styles.css"/>
</head>
<body>
<header>
  <nav>
    <ul>
      <li><a href="index.jsp">Home</a></li>
      <li><a href="login.jsp">Link2</a></li>
      <li><a href="login.jsp">Link2</a></li>
      <li><a href="login.jsp">Link3</a></li>
      <li><a href="login.jsp">Link4</a></li>
      <li><a href="login.jsp">Link5</a></li>
    </ul>
    <div>
      <button id="registar">Sign Up</button>
    </div>
  </nav>
</header>

<main>
  <div class="container">
    <h2>Login</h2>
    <form action="logIn" method="post">
      <div>
        <div class="row">
          <label>username: </label>
          <input type="text" name="username" required>
        </div>
        <div class="row">
          <label>password: </label>
          <input type="password" name="password" required>
        </div>
      </div>
      <button type="submit">Login</button>
    </form>
  </div>
</main>

<!-- Modal -->

</body>
</html>