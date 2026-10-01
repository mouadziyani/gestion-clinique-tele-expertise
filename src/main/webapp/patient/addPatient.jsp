<%@ page import="java.util.Map, java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Fiche patient</title>
</head>
<body>
<h1>Add patient</h1>

<%
    Map errors = (Map) request.getAttribute("errors");
    if (errors == null) {
        errors = new HashMap();
    }
%>

<form action="<%= request.getContextPath() + "/nurse/patient/add" %>" method="post">
    <p>
        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" required>
        <% if (errors.containsKey("nom")) { %>
            <span style="color: red"><%= errors.get("nom") %></span>
        <% } %>
    </p>
    <p>
        <label for="prenom">Prénom :</label>
        <input type="text" id="prenom" name="prenom" required>
        <% if (errors.containsKey("prenom")) { %>
            <span style="color: red"><%= errors.get("prenom") %></span>
        <% } %>
    </p>
    <p>
        <label for="dateNaissance">Date de naissance :</label>
        <input type="date" id="dateNaissance" name="dateNaissance" required>
        <% if (errors.containsKey("dateNaissance")) { %>
            <span style="color: red"><%= errors.get("dateNaissance") %></span>
        <% } %>
    </p>
    <p>
        <label for="numeroSecuriteSociale">N° de sécurité sociale :</label>
        <input type="text" id="numeroSecuriteSociale" name="numeroSecuriteSociale"
               pattern="[0-9]{7}" maxlength="7" placeholder="7 chiffres" required>
        <% if (errors.containsKey("numeroSecuriteSociale")) { %>
            <span style="color: red"><%= errors.get("numeroSecuriteSociale") %></span>
        <% } %>
    </p>
    <p>
        <label for="tensionArterielle">Tension artérielle :</label>
        <input type="text" id="tensionArterielle" name="tensionArterielle"
               placeholder="ex : 12/8" required>
        <% if (errors.containsKey("tensionArterielle")) { %>
            <span style="color: red"><%= errors.get("tensionArterielle") %></span>
        <% } %>
    </p>
    <p>
        <label for="frequenceCardiaque">Fréquence cardiaque (bpm) :</label>
        <input type="number" id="frequenceCardiaque" name="frequenceCardiaque"
               step="any" min="0" required>
        <% if (errors.containsKey("frequenceCardiaque")) { %>
            <span style="color: red"><%= errors.get("frequenceCardiaque") %></span>
        <% } %>
    </p>
    <p>
        <label for="temperature">Température (°C) :</label>
        <input type="number" id="temperature" name="temperature"
               step="0.1" min="30" max="45" required>
        <% if (errors.containsKey("temperature")) { %>
            <span style="color: red"><%= errors.get("temperature") %></span>
        <% } %>
    </p>
    <p>
        <label for="frequenceRespiratoire">Fréquence respiratoire (cycles/min) :</label>
        <input type="number" id="frequenceRespiratoire" name="frequenceRespiratoire"
               step="any" min="0" required>
        <% if (errors.containsKey("frequenceRespiratoire")) { %>
            <span style="color: red"><%= errors.get("frequenceRespiratoire") %></span>
        <% } %>
    </p>

    <button type="submit">Enregistrer</button>
    <button type="reset">Effacer</button>
</form>
</body>
</html>