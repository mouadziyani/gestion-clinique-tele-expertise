<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="ma.youcode.clinic.modal.enums.StatutConsultation" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier la Consultation - Espace Médical</title>
    
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
            --input-bg: #f8fafc;
            --border-color: #cbd5e1;
            --danger: #ef4444;
            --danger-hover: #dc2626;
            --secondary-bg: #f1f5f9;
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
            max-width: 900px;
            margin: 0 auto;
            position: relative;
            z-index: 10;
        }

        /* Header Card */
        .header-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 28px 32px;
            margin-bottom: 24px;
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
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            font-size: 26px;
            box-shadow: 0 8px 18px rgba(2, 132, 199, 0.3);
        }

        .header-title-box h1 {
            font-size: 24px;
            font-weight: 800;
            color: var(--text-main);
            letter-spacing: -0.5px;
        }

        .header-title-box p {
            font-size: 13.5px;
            color: var(--text-muted);
            margin-top: 2px;
            font-weight: 500;
        }

        /* Form Card */
        .form-card {
            background: var(--card-bg);
            border-radius: 24px;
            padding: 36px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.4);
            animation: fadeIn 0.6s ease;
        }

        /* Info Grid Summary Box */
        .info-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 16px;
            background: var(--input-bg);
            border: 1px solid #e2e8f0;
            padding: 20px;
            border-radius: 16px;
            margin-bottom: 28px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .info-item-icon {
            width: 42px;
            height: 42px;
            background: #e0f2fe;
            color: var(--primary);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
        }

        .info-item-details label {
            display: block;
            font-size: 11.5px;
            font-weight: 700;
            text-transform: uppercase;
            color: var(--text-muted);
            letter-spacing: 0.5px;
        }

        .info-item-details span {
            font-size: 14.5px;
            font-weight: 700;
            color: var(--text-main);
        }

        /* Form Groups & Inputs */
        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-main);
            font-size: 14px;
            font-weight: 700;
        }

        .input-wrapper {
            position: relative;
        }

        textarea, input[type="number"] {
            width: 100%;
            padding: 14px 16px;
            background-color: var(--input-bg);
            border: 2px solid var(--border-color);
            border-radius: 14px;
            font-size: 14.5px;
            font-weight: 500;
            color: var(--text-main);
            outline: none;
            transition: all 0.2s ease;
            resize: vertical;
        }

        textarea:focus, input[type="number"]:focus {
            border-color: var(--primary);
            background-color: #ffffff;
            box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.12);
        }

        /* Validation Error Messaging */
        .error-message {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: var(--danger);
            font-size: 12.5px;
            font-weight: 600;
            margin-top: 6px;
        }

        /* Form Actions & Buttons */
        .form-actions {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 32px;
            padding-top: 20px;
            border-top: 1px solid #f1f5f9;
        }

        .btn {
            padding: 14px 24px;
            border: none;
            border-radius: 12px;
            font-size: 14.5px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--primary), var(--primary-hover));
            color: #ffffff;
            box-shadow: 0 6px 16px rgba(2, 132, 199, 0.25);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(2, 132, 199, 0.35);
        }

        .btn-reset {
            background-color: var(--secondary-bg);
            color: var(--text-muted);
            border: 1px solid #e2e8f0;
        }

        .btn-reset:hover {
            background-color: #e2e8f0;
            color: var(--text-main);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
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
                    <i class="fa-solid fa-file-medical"></i>
                </div>
                <div>
                    <h1>Modifier la Consultation</h1>
                    <p>Mise à jour du dossier médical du patient</p>
                </div>
            </div>
        </div>

        <!-- Form Card -->
        <div class="form-card">
            
            <!-- Summary Info Section -->
            <div class="info-summary">
                <div class="info-item">
                    <div class="info-item-icon">
                        <i class="fa-solid fa-user-injured"></i>
                    </div>
                    <div class="info-item-details">
                        <label>Patient</label>
                        <span>${consultation.patient.nom} ${consultation.patient.prenom}</span>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-item-icon">
                        <i class="fa-solid fa-user-doctor"></i>
                    </div>
                    <div class="info-item-details">
                        <label>Médecin Traitant</label>
                        <span>Dr. ${consultation.doctor.username}</span>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-item-icon">
                        <i class="fa-solid fa-clipboard-question"></i>
                    </div>
                    <div class="info-item-details">
                        <label>Motif de visite</label>
                        <span>${consultation.motif}</span>
                    </div>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/generalist/consultation/edit" method="post">

                <input type="hidden" name="csrfToken" value="${csrfToken}">
                <input type="hidden" name="id" value="${consultation.id}">

                <!-- Observations Field -->
                <div class="form-group">
                    <label for="observations">
                        <i class="fa-solid fa-notes-medical" style="color: var(--primary); margin-right: 6px;"></i> Observations
                    </label>
                    <div class="input-wrapper">
                        <textarea
                            id="observations"
                            name="observations"
                            rows="4"
                            placeholder="Saisissez vos observations cliniques...">${consultation.observations}</textarea>
                    </div>
                    <c:if test="${not empty errors.observations}">
                        <div class="error-message">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            <span>${errors.observations}</span>
                        </div>
                    </c:if>
                </div>

                <!-- Diagnostic Field -->
                <div class="form-group">
                    <label for="diagnostic">
                        <i class="fa-solid fa-stethoscope" style="color: var(--primary); margin-right: 6px;"></i> Diagnostic
                    </label>
                    <div class="input-wrapper">
                        <textarea
                            id="diagnostic"
                            name="diagnostic"
                            rows="4"
                            placeholder="Saisissez le diagnostic établi...">${consultation.diagnostic}</textarea>
                    </div>
                    <c:if test="${not empty errors.diagnostic}">
                        <div class="error-message">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            <span>${errors.diagnostic}</span>
                        </div>
                    </c:if>
                </div>

                <!-- Treatment Field -->
                <div class="form-group">
                    <label for="treatment">
                        <i class="fa-solid fa-pills" style="color: var(--primary); margin-right: 6px;"></i> Traitement prescrit
                    </label>
                    <div class="input-wrapper">
                        <textarea
                            id="treatment"
                            name="treatment"
                            rows="4"
                            placeholder="Détails du traitement et ordonnance...">${consultation.treatment}</textarea>
                    </div>
                    <c:if test="${not empty errors.treatment}">
                        <div class="error-message">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            <span>${errors.treatment}</span>
                        </div>
                    </c:if>
                </div>

                <!-- Cost Field -->
                <div class="form-group">
                    <label for="cout">
                        <i class="fa-solid fa-receipt" style="color: var(--primary); margin-right: 6px;"></i> Coût (MAD)
                    </label>
                    <div class="input-wrapper" style="max-width: 280px;">
                        <input
                            type="number"
                            id="cout"
                            name="cout"
                            step="0.01"
                            min="0"
                            placeholder="0.00"
                            value="${consultation.cout}"
                            required>
                    </div>
                    <c:if test="${not empty errors.cout}">
                        <div class="error-message">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            <span>${errors.cout}</span>
                        </div>
                    </c:if>
                </div>

                <!-- Action Buttons -->
                <div class="form-actions">
                    <button type="reset" class="btn btn-reset">
                        <i class="fa-solid fa-rotate-left"></i> Réinitialiser
                    </button>
                    <button type="submit" class="btn btn-submit">
                        <i class="fa-solid fa-floppy-disk"></i> Enregistrer les modifications
                    </button>
                </div>

            </form>

        </div>

    </div>

</body>
</html>