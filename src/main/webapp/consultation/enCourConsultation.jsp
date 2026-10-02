<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Consultation</title>
</head>
<body>
<h1>Consultations</h1>

<table border="1">
    <thead>
    <tr>
        <th>Patient</th>
        <th>Date naissance</th>
        <th>Date arrivée</th>
        <th>Motif</th>
        <th>Action</th>
    </tr>
    </thead>

    <tbody>

    <c:forEach var="consultation" items="${enCourConsultations}">
        <tr>
            <td>${consultation.patient.nom} ${consultation.patient.prenom}</td>
            <td>${consultation.patient.dateNaissance}</td>
            <td>${consultation.patient.dateArrivee}</td>
            <td>${consultation.motif}</td>
            <td>
                <form action="${pageContext.request.contextPath}/generalist/consultation/edit" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="${consultation.id}">
                    <button type="submit">Consulter</button>
                </form>
                <form action="${pageContext.request.contextPath}/generalist/consultation/delete" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="${consultation.id}">
                    <button type="submit" onclick="return confirm('Voulez-vous supprimer cette consultation ?');">Supprimer</button>
                </form>
            </td>
        </tr>
    </c:forEach>

    </tbody>
</table>
</body>
</html>