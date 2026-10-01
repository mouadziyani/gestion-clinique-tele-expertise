<%@ page import="java.util.Map, java.util.HashMap" %>
<%@ page import="ma.youcode.clinic.modal.enums.StatutConsultation" %>
<%@ page import="ma.youcode.clinic.modal.Patient" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Consultation</title>
</head>
<body>

<h1>Ajouter une consultation</h1>

<%
    Map errors = (Map) request.getAttribute("errors");

    if (errors == null) {
        errors = new HashMap();
    }
%>

<form action="<%= request.getContextPath() + "/doctor/consultation/add" %>" method="post">

    <p>
        <label for="patient">Patient :</label>

        <select id="patient" name="patientId" required>
            <option value="" disabled selected>-- Sélectionner un patient --</option>

            <%
                 List<Patient> patients = (List<Patient>) request.getAttribute("patients");
                 for (Patient patient : patients) {
            %>

            <option value="<%= patient.getId() %>">
                <%= patient.getNom() + patient.getPrenom() %>
            </option>

            <%
                 }
            %>
        </select>

        <% if (errors.containsKey("patientId")) { %>
        <span style="color: red">
                <%= errors.get("patientId") %>
            </span>
        <% } %>
    </p>


    <p>
        <label for="motif">Motif :</label>

        <textarea id="motif" name="motif" rows="3" required></textarea>

        <% if (errors.containsKey("motif")) { %>
        <span style="color: red">
                <%= errors.get("motif") %>
            </span>
        <% } %>
    </p>

    <p>
        <label for="observations">Observations :</label>

        <textarea id="observations" name="observations" rows="5"></textarea>

        <% if (errors.containsKey("observations")) { %>
        <span style="color: red">
                <%= errors.get("observations") %>
            </span>
        <% } %>
    </p>


    <p>
        <label for="diagnostic">Diagnostic :</label>

        <textarea id="diagnostic" name="diagnostic" rows="5"></textarea>

        <% if (errors.containsKey("diagnostic")) { %>
        <span style="color: red">
                <%= errors.get("diagnostic") %>
            </span>
        <% } %>
    </p>


    <p>
        <label for="treatment">Traitement :</label>

        <textarea id="treatment" name="treatment" rows="5"></textarea>

        <% if (errors.containsKey("treatment")) { %>
        <span style="color: red">
                <%= errors.get("treatment") %>
            </span>
        <% } %>
    </p>


    <p>
        <label for="cout">Coût :</label>

        <input type="number" id="cout" name="cout" step="0.01" min="0" required>

        <% if (errors.containsKey("cout")) { %>
        <span style="color: red">
                <%= errors.get("cout") %>
            </span>
        <% } %>
    </p>


    <p>
        <label for="statut">Statut :</label>

        <select id="statut" name="statut" required>

            <option value="" selected disabled>-- Sélectionner un statut --</option>

            <%
                for (StatutConsultation statut : StatutConsultation.values()) {
            %>

            <option value="<%= statut.name() %>">
                <%= statut.name() %>
            </option>

            <%
                }
            %>

        </select>

        <% if (errors.containsKey("statut")) { %>
        <span style="color: red">
                <%= errors.get("statut") %>
            </span>
        <% } %>
    </p>


    <p>
        <label for="dateConsultation">Date de consultation :</label>

        <input
                type="datetime-local"
                id="dateConsultation"
                name="dateConsultation"
                required>

        <% if (errors.containsKey("dateConsultation")) { %>
        <span style="color: red">
                <%= errors.get("dateConsultation") %>
            </span>
        <% } %>
    </p>


    <button type="submit">Enregistrer</button>
    <button type="reset">Effacer</button>

</form>

</body>
</html>
