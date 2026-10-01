<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
</head>

<body>

    <h1>Nurse</h1>
    <a href="<%= request.getContextPath() + "/nurse/patient/add" %>">Add Patient</a>
    <a href="<%= request.getContextPath() + "/nurse/patient/today" %>">Patient d'aujourd'hui</a>
    <a href="<%= request.getContextPath() %>/auth/logout">Logout</a>

</body>
</html>
