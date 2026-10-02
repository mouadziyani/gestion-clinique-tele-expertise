<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Fiche patient</title>
</head>

<body>

<h1>Add patient</h1>

<form action="${pageContext.request.contextPath}/nurse/patient/add"
      method="post">

    <input type="hidden"
           name="csrfToken"
           value="${csrfToken}">

    <p>
        <label for="nom">Nom :</label>

        <input type="text"
               id="nom"
               name="nom"
               value="${param.nom}"
               required>

        <c:if test="${not empty errors.nom}">
            <span style="color: red">
                    ${errors.nom}
            </span>
        </c:if>
    </p>

    <p>
        <label for="prenom">Prénom :</label>

        <input type="text"
               id="prenom"
               name="prenom"
               value="${param.prenom}"
               required>

        <c:if test="${not empty errors.prenom}">
            <span style="color: red">
                    ${errors.prenom}
            </span>
        </c:if>
    </p>

    <p>
        <label for="dateNaissance">Date de naissance :</label>

        <input type="date"
               id="dateNaissance"
               name="dateNaissance"
               value="${param.dateNaissance}"
               required>

        <c:if test="${not empty errors.dateNaissance}">
            <span style="color: red">
                    ${errors.dateNaissance}
            </span>
        </c:if>
    </p>

    <p>
        <label for="numeroSecuriteSociale">
            N° de sécurité sociale :
        </label>

        <input type="text"
               id="numeroSecuriteSociale"
               name="numeroSecuriteSociale"
               value="${param.numeroSecuriteSociale}"
               pattern="[0-9]{7}"
               maxlength="7"
               placeholder="7 chiffres"
               required>

        <c:if test="${not empty errors.numeroSecuriteSociale}">
            <span style="color: red">
                    ${errors.numeroSecuriteSociale}
            </span>
        </c:if>
    </p>

    <p>
        <label for="motif">
            Motif de consultation :
        </label>

        <textarea id="motif"
                  name="motif"
                  rows="3"
                  placeholder="Ex : Fièvre, douleur abdominale..."
                  required>${param.motif}</textarea>

        <c:if test="${not empty errors.motif}">
            <span style="color: red">
                    ${errors.motif}
            </span>
        </c:if>
    </p>

    <p>
        <label for="doctorId">
            Médecin :
        </label>

        <select id="doctorId"
                name="doctorId"
                required>

            <option value="" disabled selected>
                -- Choisir un médecin --
            </option>

            <c:forEach var="doctor" items="${doctors}">

                <option value="${doctor.id}"
                    ${param.doctorId == doctor.id ? 'selected' : ''}>

                    Dr. ${doctor.username}

                </option>

            </c:forEach>

        </select>

        <c:if test="${not empty errors.doctorId}">
            <span style="color: red">
                    ${errors.doctorId}
            </span>
        </c:if>
    </p>

    <p>
        <label for="tensionArterielle">
            Tension artérielle :
        </label>

        <input type="text"
               id="tensionArterielle"
               name="tensionArterielle"
               value="${param.tensionArterielle}"
               placeholder="ex : 12/8"
               required>

        <c:if test="${not empty errors.tensionArterielle}">
            <span style="color: red">
                    ${errors.tensionArterielle}
            </span>
        </c:if>
    </p>

    <p>
        <label for="frequenceCardiaque">
            Fréquence cardiaque (bpm) :
        </label>

        <input type="number"
               id="frequenceCardiaque"
               name="frequenceCardiaque"
               value="${param.frequenceCardiaque}"
               step="any"
               min="0"
               required>

        <c:if test="${not empty errors.frequenceCardiaque}">
            <span style="color: red">
                    ${errors.frequenceCardiaque}
            </span>
        </c:if>
    </p>

    <p>
        <label for="temperature">
            Température (°C) :
        </label>

        <input type="number"
               id="temperature"
               name="temperature"
               value="${param.temperature}"
               step="0.1"
               min="30"
               max="45"
               required>

        <c:if test="${not empty errors.temperature}">
            <span style="color: red">
                    ${errors.temperature}
            </span>
        </c:if>
    </p>

    <p>
        <label for="frequenceRespiratoire">
            Fréquence respiratoire (cycles/min) :
        </label>

        <input type="number"
               id="frequenceRespiratoire"
               name="frequenceRespiratoire"
               value="${param.frequenceRespiratoire}"
               step="any"
               min="0"
               required>

        <c:if test="${not empty errors.frequenceRespiratoire}">
            <span style="color: red">
                    ${errors.frequenceRespiratoire}
            </span>
        </c:if>
    </p>

    <button type="submit">Enregistrer</button>
    <button type="reset">Effacer</button>

</form>

</body>
</html>