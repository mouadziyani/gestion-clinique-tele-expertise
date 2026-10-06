<%@ page import="java.util.List" %>
<%@ page import="ma.youcode.clinic.modal.Patient" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Espace Infirmerie - Patients du jour</title>
    
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
            --border-color: #e2e8f0;
            --badge-bg: #e0f2fe;
            --badge-text: #0369a1;
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

        .action-buttons {
            display: flex;
            gap: 12px;
        }

        .btn-action {
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

        .btn-action:hover {
            background: #e2e8f0;
            color: var(--primary);
        }

        .btn-primary-action {
            background: linear-gradient(135deg, var(--primary), var(--primary-hover));
            color: #ffffff;
            border: none;
            box-shadow: 0 4px 12px rgba(2, 132, 199, 0.25);
        }

        .btn-primary-action:hover {
            background: var(--primary-hover);
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(2, 132, 199, 0.35);
        }

        /* Content Card / List */
        .content-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 32px;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.6s ease;
        }

        .patients-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .patient-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #f8fafc;
            border: 1.5px solid var(--border-color);
            padding: 18px 24px;
            border-radius: 16px;
            transition: all 0.3s ease;
        }

        .patient-item:hover {
            border-color: var(--primary);
            background: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(2, 132, 199, 0.15);
        }

        .patient-info {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .patient-avatar {
            width: 44px;
            height: 44px;
            background: var(--badge-bg);
            color: var(--primary);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            font-weight: 700;
        }

        .patient-name {
            font-size: 16px;
            font-weight: 700;
            color: var(--text-main);
        }

        .patient-time {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: var(--badge-bg);
            color: var(--badge-text);
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: var(--text-muted);
        }

        .empty-state i {
            font-size: 48px;
            color: #cbd5e1;
            margin-bottom: 12px;
        }

        .empty-state p {
            font-size: 15px;
            font-weight: 500;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 600px) {
            .patient-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }
            .patient-time {
                align-self: flex-start;
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
                    <i class="fa-solid fa-calendar-day"></i>
                </div>
                <div>
                    <h1>Patients d'aujourd'hui</h1>
                    <p>Suivi des admissions et rendez-vous du jour</p>
                </div>
            </div>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/nurse/patient/add" class="btn-action btn-primary-action">
                    <i class="fa-solid fa-user-plus"></i> Nouveau
                </a>
            </div>
        </div>

        <!-- Content Card -->
        <div class="content-card">
            <%
                List<Patient> patients = (List<Patient>) request.getAttribute("todayPatients");
                if (patients != null && !patients.isEmpty()) {
            %>
                <ul class="patients-list">
                    <%
                        for (Patient patient : patients) {
                    %>
                        <li class="patient-item">
                            <div class="patient-info">
                                <div class="patient-avatar">
                                    <i class="fa-solid fa-user"></i>
                                </div>
                                <div>
                                    <div class="patient-name">
                                        <%= patient.getNom() + " " + patient.getPrenom() %>
                                    </div>
                                </div>
                            </div>
                            <div class="patient-time">
                                <i class="fa-regular fa-clock"></i> <%= patient.getDateArrivee() %>
                            </div>
                        </li>
                    <% } %>
                </ul>
            <% 
                } else {
            %>
                <div class="empty-state">
                    <i class="fa-solid fa-folder-open"></i>
                    <p>Aucun patient enregistré pour aujourd'hui.</p>
                </div>
            <% } %>
        </div>

    </div>

</body>
</html>