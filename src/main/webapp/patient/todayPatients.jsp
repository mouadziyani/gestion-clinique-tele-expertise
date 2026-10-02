<%@ page import="java.util.List" %>
<%@ page import="ma.youcode.clinic.modal.Patient" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title>Connexion</title>
    </head>

    <body>

        <h1>Today Patient</h1>

        <ul>
            <%
                List<Patient> patients = (List<Patient>) request.getAttribute("todayPatients");

                for (Patient patient : patients) {
            %>



            <li>
                <%= patient.getNom() + " " + patient.getPrenom() + " - " + patient.getDateArrivee() %>
            </li>

            <% } %>
        </ul>






    </body>
</html>
