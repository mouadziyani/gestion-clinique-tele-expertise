<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Consultations - Espace Médical</title>
    
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
            --border-color: #e2e8f0;
            --danger: #ef4444;
            --danger-hover: #dc2626;
            --success: #10b981;
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
            max-width: 1100px;
            margin: 0 auto;
            position: relative;
            z-index: 10;
        }

        /* Page Top Header Card */
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

        .live-status {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #ecfdf5;
            color: #047857;
            border: 1px solid #a7f3d0;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
        }

        .pulse-dot {
            width: 8px;
            height: 8px;
            background-color: var(--success);
            border-radius: 50%;
            box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7);
            animation: pulseGlow 1.8s infinite;
        }

        @keyframes pulseGlow {
            0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7); }
            70% { box-shadow: 0 0 0 8px rgba(16, 185, 129, 0); }
            100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
        }

        /* Table Card & Container */
        .table-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.4);
            overflow: hidden;
            animation: fadeIn 0.6s ease;
        }

        .table-responsive {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            text-align: left;
        }

        thead th {
            background-color: #f8fafc;
            color: var(--text-muted);
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            padding: 16px 20px;
            border-bottom: 2px solid var(--border-color);
        }

        thead th:first-child {
            border-top-left-radius: 12px;
        }

        thead th:last-child {
            border-top-right-radius: 12px;
        }

        tbody tr {
            transition: all 0.2s ease;
        }

        tbody tr:hover {
            background-color: #f1f5f9;
        }

        tbody td {
            padding: 18px 20px;
            border-bottom: 1px solid var(--border-color);
            font-size: 14px;
            color: var(--text-main);
            vertical-align: middle;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        /* Column Specific Styles */
        .patient-name {
            font-weight: 700;
            color: var(--text-main);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .patient-avatar {
            width: 36px;
            height: 36px;
            background: #e0f2fe;
            color: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: 700;
        }

        .motif-badge {
            display: inline-block;
            background: #f1f5f9;
            color: #334155;
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 500;
        }

        .date-cell {
            color: var(--text-muted);
            font-size: 13.5px;
            font-weight: 500;
        }

        /* Action Buttons */
        .actions-cell {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-action {
            padding: 9px 16px;
            border: none;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-consult {
            background: linear-gradient(135deg, var(--primary), var(--primary-hover));
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
        }

        .btn-consult:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(2, 132, 199, 0.35);
        }

        .btn-delete {
            background-color: #fef2f2;
            color: var(--danger);
            border: 1px solid #fecaca;
        }

        .btn-delete:hover {
            background-color: var(--danger);
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.25);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: var(--text-muted);
        }

        .empty-state i {
            font-size: 45px;
            color: #cbd5e1;
            margin-bottom: 12px;
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
                    <i class="fa-solid fa-stethoscope"></i>
                </div>
                <div>
                    <h1>Liste des Consultations</h1>
                    <p>Gestion et suivi des patients en attente</p>
                </div>
            </div>
            <div class="live-status">
                <span class="pulse-dot"></span>
                <span>File d'attente active</span>
            </div>
        </div>

        <!-- Table Card -->
        <div class="table-card">
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>Patient</th>
                            <th>Date de Naissance</th>
                            <th>Date d'Arrivée</th>
                            <th>Motif</th>
                            <th style="text-align: right;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="consultation" items="${enCourConsultations}">
                            <tr>
                                <td>
                                    <div class="patient-name">
                                        <div class="patient-avatar">
                                            <i class="fa-solid fa-user"></i>
                                        </div>
                                        <span>${consultation.patient.nom} ${consultation.patient.prenom}</span>
                                    </div>
                                </td>
                                <td>
                                    <span class="date-cell">
                                        <i class="fa-regular fa-calendar-days"></i> ${consultation.patient.dateNaissance}
                                    </span>
                                </td>
                                <td>
                                    <span class="date-cell">
                                        <i class="fa-regular fa-clock"></i> ${consultation.patient.dateArrivee}
                                    </span>
                                </td>
                                <td>
                                    <span class="motif-badge">${consultation.motif}</span>
                                </td>
                                <td>
                                    <div class="actions-cell" style="justify-content: flex-end;">
                                        <!-- Form Consulter -->
                                        <form action="${pageContext.request.contextPath}/generalist/consultation/edit" method="get" style="margin: 0;">
                                            <input type="hidden" name="id" value="${consultation.id}">
                                            <button type="submit" class="btn-action btn-consult">
                                                <i class="fa-solid fa-stethoscope"></i> Consulter
                                            </button>
                                        </form>

                                        <!-- Form Supprimer -->
                                        <form action="${pageContext.request.contextPath}/generalist/consultation/delete" method="post" style="margin: 0;">
                                            <input type="hidden" name="id" value="${consultation.id}">
                                            <button type="submit" class="btn-action btn-delete" onclick="return confirm('Voulez-vous vraiment supprimer cette consultation ?');">
                                                <i class="fa-solid fa-trash-can"></i> Supprimer
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <!-- Fallback Ila kano makaynish consultations -->
                        <c:if test="${empty enCourConsultations}">
                            <tr>
                                <td colspan="5">
                                    <div class="empty-state">
                                        <i class="fa-solid fa-folder-open"></i>
                                        <p>Aucune consultation en attente pour le moment.</p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

</body>
</html>