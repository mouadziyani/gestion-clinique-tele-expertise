<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Espace Infirmerie - Nouveau Patient</title>
    
    <!-- Icons & Typography -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #0284c7;
            --primary-hover: #0369a1;
            --accent: #0d9488;
            --bg-start: #0f172a;
            --bg-end: #1e293b;
            --card-bg: #ffffff;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --danger-bg: #fef2f2;
            --danger-text: #ef4444;
            --danger-hover: #dc2626;
            --border-color: #e2e8f0;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, var(--bg-start), var(--bg-end));
            color: var(--text-main);
            padding: 40px 20px;
            position: relative;
        }

        /* Medical Grid Background */
        .bg-grid {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(circle at 20px 20px, rgba(255, 255, 255, 0.04) 2px, transparent 0);
            background-size: 40px 40px;
            z-index: 1;
            pointer-events: none;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            position: relative;
            z-index: 10;
        }

        /* Top Header Card */
        .header-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 24px 32px;
            margin-bottom: 28px;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.3);
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 20px;
            animation: fadeIn 0.5s ease;
        }

        .header-title-box {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .header-icon {
            width: 52px;
            height: 52px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            font-size: 24px;
            box-shadow: 0 8px 18px rgba(2, 132, 199, 0.3);
        }

        .header-title-box h1 {
            font-size: 22px;
            font-weight: 800;
            color: var(--text-main);
            letter-spacing: -0.5px;
        }

        .header-title-box p {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 2px;
            font-weight: 500;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 18px;
            background: #f8fafc;
            border: 1px solid var(--border-color);
            color: var(--text-main);
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 13.5px;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background: #e2e8f0;
            color: var(--primary);
        }

        /* Form Card */
        .form-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 36px;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.6s ease;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        label {
            font-size: 13.5px;
            font-weight: 700;
            color: var(--text-main);
        }

        input[type="text"],
        input[type="date"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 12px 16px;
            border: 1.5px solid var(--border-color);
            border-radius: 12px;
            font-size: 14px;
            color: var(--text-main);
            background-color: #f8fafc;
            transition: all 0.3s ease;
            outline: none;
        }

        input:focus, select:focus, textarea:focus {
            border-color: var(--primary);
            background-color: #ffffff;
            box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.1);
        }

        textarea {
            resize: vertical;
        }

        .error-message {
            font-size: 12px;
            color: var(--danger-text);
            font-weight: 600;
            margin-top: 2px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        /* Form Actions Buttons */
        .form-actions {
            grid-column: span 2;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 10px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
        }

        button {
            padding: 12px 24px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
        }

        button[type="submit"] {
            background: linear-gradient(135deg, var(--primary), var(--primary-hover));
            color: #ffffff;
            box-shadow: 0 6px 16px rgba(2, 132, 199, 0.3);
        }

        button[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(2, 132, 199, 0.4);
        }

        button[type="reset"] {
            background: #f1f5f9;
            color: var(--text-muted);
            border: 1px solid var(--border-color);
        }

        button[type="reset"]:hover {
            background: #e2e8f0;
            color: var(--text-main);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            .form-group.full-width {
                grid-column: span 1;
            }
            .form-actions {
                grid-column: span 1;
                flex-direction: column-reverse;
            }
            button {
                width: 100%;
            }
        }
    </style>
</head>
<body>

    <div class="bg-grid"></div>

    <div class="container">
        
        <!-- Header -->
        <div class="header-card">
            <div class="header-title-box">
                <div class="header-icon">
                    <i class="fa-solid fa-user-plus"></i>
                </div>
                <div>
                    <h1>Nouveau Patient</h1>
                    <p>Enregistrer un nouveau patient et ses constantes</p>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/nurse/patients/today" class="back-link">
                <i class="fa-solid fa-arrow-left"></i> Retour
            </a>
        </div>

        <!-- Form Card Container -->
        <div class="form-card">
            <form action="${pageContext.request.contextPath}/nurse/patient/add" method="post">

                <input type="hidden" name="csrfToken" value="${csrfToken}">

                <div class="form-grid">
                    
                    <!-- Nom -->
                    <div class="form-group">
                        <label for="nom">Nom :</label>
                        <input type="text" id="nom" name="nom" value="${param.nom}" required>
                        <c:if test="${not empty errors.nom}">
                            <span class="error-message"><i class="fa-solid fa-circle-exclamation"></i> ${errors.nom}</span>
                        </c:if>
                    </div>

                    <!-- Prénom -->
                    <div class="form-group">
                        <label for="prenom">Prénom :</label>
                        <input type="text" id="prenom" name="prenom" value="${param.prenom}" required>
                        <c:if test="${not empty errors.prenom}">
                            <span class="error-message"><i class="fa-solid fa-circle-exclamation"></i> ${errors.prenom}</span>
                        </c:if>
                    </div>

                    <!-- Date de naissance -->
                    <div class="form-group">
                        <label for="dateNaissance">Date de naissance :</label>
                        <input type="date" id="dateNaissance" name="dateNaissance" value="${param.dateNaissance}" required>
                        <c:if test="${not empty errors.dateNaissance}">
                            <span class="error-message"><i class="fa-solid fa-circle-exclamation"></i> ${errors.dateNaissance}</span>
                        </c:if>
                    </div>

                    <!-- N° de sécurité sociale -->
                    <div class="form-group">
                        <label for="numeroSecuriteSociale">N° de sécurité sociale :</label>
                        <input type="text" id="numeroSecuriteSociale" name="numeroSecuriteSociale" 
                               value="${param.numeroSecuriteSociale}" pattern="[0-9]{7}" maxlength="7" 
                               placeholder="7 chiffres" required>
                        <c:if test="${not empty errors.numeroSecuriteSociale}">
                            <span class="error-message"><i class="fa-solid fa-circle-exclamation"></i> ${errors.numeroSecuriteSociale}</span>
                        </c:if>
                    </div>

                    <!-- Médecin -->
                    <div class="form-group full-width">
                        <label for="doctorId">Médecin :</label>
                        <select id="doctorId" name="doctorId" required>
                            <option value="" disabled selected>-- Choisir un médecin --</option>
                            <c:forEach var="doctor" items="${doctors}">
                                <option value="${doctor.id}" ${param.doctorId == doctor.id ? 'selected' : ''}>
                                    Dr. ${doctor.username}
                                </option>
                            </c:forEach>
                        </select>
                        <c:if test="${not empty errors.doctorId}">
                            <span class="error-message"><i class="fa-solid fa-circle-exclamation"></i> ${errors.doctorId}</span>
                        </c:if>
                    </div>

                    <!-- Motif de consultation -->
                    <div class="form-group full-width">
                        <label for="motif">Motif de consultation :</label>
                        <textarea id="motif" name="motif" rows="3" placeholder="Ex : Fièvre, douleur abdominale..." required>${param.motif}</textarea>
                        <c:if test="${not empty errors.motif}">
                            <span class="error-message"><i class="fa-solid fa-circle-exclamation"></i> ${errors.motif}</span>
                        </c:if>
                    </div>

                    <!-- Tension artérielle -->
                    <div class="form-group">
                        <label for="tensionArterielle">Tension artérielle :</label>
                        <input type="text" id="tensionArterielle" name="tensionArterielle" 
                               value="${param.tensionArterielle}" placeholder="ex : 12/8" required>
                        <c:if test="${not empty errors.tensionArterielle}">
                            <span class="error-message"><i class="fa-solid fa-circle-exclamation"></i> ${errors.tensionArterielle}</span>
                        </c:if>
                    </div>

                    <!-- Fréquence cardiaque -->
                    <div class="form-group">
                        <label for="frequenceCardiaque">Fréquence cardiaque (bpm) :</label>
                        <input type="number" id="frequenceCardiaque" name="frequenceCardiaque" 
                               value="${param.frequenceCardiaque}" step="any" min="0" required>
                        <c:if test="${not empty errors.frequenceCardiaque}">
                            <span class="error-message"><i class="fa-solid fa-circle-exclamation"></i> ${errors.frequenceCardiaque}</span>
                        </c:if>
                    </div>

                    <!-- Température -->
                    <div class="form-group">
                        <label for="temperature">Température (°C) :</label>
                        <input type="number" id="temperature" name="temperature" 
                               value="${param.temperature}" step="0.1" min="30" max="45" required>
                        <c:if test="${not empty errors.temperature}">
                            <span class="error-message"><i class="fa-solid fa-circle-exclamation"></i> ${errors.temperature}</span>
                        </c:if>
                    </div>

                    <!-- Fréquence respiratoire -->
                    <div class="form-group">
                        <label for="frequenceRespiratoire">Fréquence respiratoire (cycles/min) :</label>
                        <input type="number" id="frequenceRespiratoire" name="frequenceRespiratoire" 
                               value="${param.frequenceRespiratoire}" step="any" min="0" required>
                        <c:if test="${not empty errors.frequenceRespiratoire}">
                            <span class="error-message"><i class="fa-solid fa-circle-exclamation"></i> ${errors.frequenceRespiratoire}</span>
                        </c:if>
                    </div>

                    <!-- Actions -->
                    <div class="form-actions">
                        <button type="reset" class="btn-reset">Effacer</button>
                        <button type="submit" class="btn-submit">Enregistrer</button>
                    </div>

                </div>

            </form>
        </div>

    </div>

</body>
</html>