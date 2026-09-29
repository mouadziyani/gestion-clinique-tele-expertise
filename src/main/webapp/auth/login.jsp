<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
</head>

<body>

<h1>Connexion</h1>

<form action="${pageContext.request.contextPath}/auth/login" method="post">

    <div>
        <label for="username">Nom d'utilisateur :</label>
        <input
                type="text"
                id="username"
                name="username"
                required
        >
    </div>

    <br>

    <div>
        <label for="password">Mot de passe :</label>
        <input
                type="password"
                id="password"
                name="password"
                required
        >
    </div>

    <br>

    <button type="submit">Se connecter</button>

</form>

</body>
</html>
