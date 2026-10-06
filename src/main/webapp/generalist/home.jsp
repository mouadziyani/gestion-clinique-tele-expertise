<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Espace Médecin Généraliste - Accueil</title>
    
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
            max-width: 900px;
            margin: 0 auto;
            position: relative;
            z-index: 10;
        }

        /* Top Header Card */
        .header-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 28px 32px;
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

        /* Navigation Quick Cards Grid */
        .nav-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            animation: fadeIn 0.6s ease;
        }

        .nav-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.3);
            text-decoration: none;
            color: var(--text-main);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            border: 1px solid transparent;
        }

        .nav-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 25px 50px -12px rgba(2, 132, 199, 0.25);
            border-color: rgba(2, 132, 199, 0.2);
        }

        .card-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .card-icon {
            width: 52px;
            height: 52px;
            background: #e0f2fe;
            color: var(--primary);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            transition: all 0.3s ease;
        }

        .nav-card:hover .card-icon {
            background: linear-gradient(135deg, var(--primary), var(--primary-hover));
            color: #ffffff;
            box-shadow: 0 6px 16px rgba(2, 132, 199, 0.3);
        }

        .card-arrow {
            font-size: 16px;
            color: var(--text-muted);
            transition: transform 0.3s ease, color 0.3s ease;
        }

        .nav-card:hover .card-arrow {
            transform: translateX(5px);
            color: var(--primary);
        }

        .card-info h2 {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 6px;
        }

        .card-info p {
            font-size: 13px;
            color: var(--text-muted);
            line-height: 1.5;
        }

        /* Logout Specific Card Variant */
        .nav-card.logout-card .card-icon {
            background: var(--danger-bg);
            color: var(--danger-text);
        }

        .nav-card.logout-card:hover .card-icon {
            background: var(--danger-text);
            color: #ffffff;
            box-shadow: 0 6px 16px rgba(239, 68, 68, 0.3);
        }

        .nav-card.logout-card:hover {
            box-shadow: 0 25px 50px -12px rgba(239, 68, 68, 0.15);
            border-color: rgba(239, 68, 68, 0.2);
        }

        .nav-card.logout-card:hover .card-arrow {
            color: var(--danger-text);
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
                    <i class="fa-solid fa-user-doctor"></i>
                </div>
                <div>
                    <h1>Espace Généraliste</h1>
                    <p>Tableau de bord et gestion des consultations</p>
                </div>
            </div>
        </div>

        <!-- Quick Access Navigation Cards -->
        <div class="nav-grid">
            
            <!-- Link to Consultations En Cours -->
            <a href="<%= request.getContextPath() %>/generalist/consultations/en_cours" class="nav-card">
                <div>
                    <div class="card-top">
                        <div class="card-icon">
                            <i class="fa-solid fa-stethoscope"></i>
                        </div>
                        <i class="fa-solid fa-arrow-right card-arrow"></i>
                    </div>
                    <div class="card-info">
                        <h2>En Consultation</h2>
                        <p>Consulter la liste des patients en attente et gérer les rendez-vous en cours.</p>
                    </div>
                </div>
            </a>

            <!-- Logout Link -->
            <a href="<%= request.getContextPath() %>/auth/logout" class="nav-card logout-card">
                <div>
                    <div class="card-top">
                        <div class="card-icon">
                            <i class="fa-solid fa-right-from-bracket"></i>
                        </div>
                        <i class="fa-solid fa-arrow-right card-arrow"></i>
                    </div>
                    <div class="card-info">
                        <h2>Déconnexion</h2>
                        <p>Fermer la session actuelle en toute sécurité.</p>
                    </div>
                </div>
            </a>

        </div>

    </div>

</body>
</html>