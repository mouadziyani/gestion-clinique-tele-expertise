<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="ma.youcode.clinic.modal.enums.StatutConsultation" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier la consultation</title>
</head>
<body>

<h1>Modifier la consultation</h1>

<form action="${pageContext.request.contextPath}/generalist/consultation/edit" method="post">

    <input type="hidden"
           name="csrfToken"
           value="${csrfToken}">

    <input type="hidden"
           name="id"
           value="${consultation.id}">


    <p>
        <strong>Patient :</strong>
        ${consultation.patient.nom}
        ${consultation.patient.prenom}
    </p>


    <p>
        <strong>Médecin :</strong> ${consultation.doctor.username}
    </p>


    <p>
        <strong>Motif :</strong>
        ${consultation.motif}
    </p>

    <p>
        <label for="observations">Observations :</label>

        <textarea
                id="observations"
                name="observations"
                rows="5">${consultation.observations}</textarea>

        <c:if test="${not empty errors.observations}">
            <span style="color: red">
                    ${errors.observations}
            </span>
        </c:if>
    </p>

    <p>
        <label for="diagnostic">Diagnostic :</label>

        <textarea
                id="diagnostic"
                name="diagnostic"
                rows="5">${consultation.diagnostic}</textarea>

        <c:if test="${not empty errors.diagnostic}">
            <span style="color: red">
                    ${errors.diagnostic}
            </span>
        </c:if>
    </p>

    <p>
        <label for="treatment">Traitement :</label>

        <textarea
                id="treatment"
                name="treatment"
                rows="5">${consultation.treatment}</textarea>

        <c:if test="${not empty errors.treatment}">
            <span style="color: red">
                    ${errors.treatment}
            </span>
        </c:if>
    </p>


    <p>
        <label for="cout">Coût :</label>

        <input
                type="number"
                id="cout"
                name="cout"
                step="0.01"
                min="0"
                value="${consultation.cout}"
                required>

        <c:if test="${not empty errors.cout}">
            <span style="color: red">
                    ${errors.cout}
            </span>
        </c:if>
    </p>

    <button type="submit">
        Enregistrer les modifications
    </button>

    <button type="reset">
        Réinitialiser
    </button>

</form>

</body>
</html>