<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Système Hospitalier</title>
    
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
            --input-border: #cbd5e1;
            --error-bg: #fef2f2;
            --error-text: #991b1b;
            --error-border: #fecaca;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--bg-start), var(--bg-end));
            position: relative;
            overflow: hidden;
            padding: 20px;
        }

        /* Subtle Medical Ambient Background Grid */
        .bg-grid {
            position: absolute;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(circle at 20px 20px, rgba(255, 255, 255, 0.05) 2px, transparent 0);
            background-size: 40px 40px;
            z-index: 1;
        }

        /* Smooth Background ECG Waveform Animation */
        .ecg-container {
            position: absolute;
            width: 100%;
            height: 180px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 1;
            opacity: 0.12;
            pointer-events: none;
        }

        .ecg-line {
            stroke: #38bdf8;
            stroke-width: 4;
            fill: none;
            stroke-dasharray: 1000;
            stroke-dashoffset: 1000;
            animation: ecgFlow 3.5s linear infinite;
        }

        @keyframes ecgFlow {
            0% { stroke-dashoffset: 1000; }
            100% { stroke-dashoffset: 0; }
        }

        /* Main Login Card */
        .login-card {
            position: relative;
            z-index: 10;
            width: 100%;
            max-width: 440px;
            background: var(--card-bg);
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5), 
                        0 0 0 1px rgba(255, 255, 255, 0.1);
            padding: 42px 38px;
            animation: cardAppear 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes cardAppear {
            from {
                opacity: 0;
                transform: translateY(25px) scale(0.98);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        /* Hospital Header & Status Badge */
        .brand-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .live-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background-color: #ecfdf5;
            color: #047857;
            border: 1px solid #a7f3d0;
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            margin-bottom: 18px;
        }

        .pulse-dot {
            width: 8px;
            height: 8px;
            background-color: #10b981;
            border-radius: 50%;
            box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7);
            animation: pulseGlow 1.8s infinite;
        }

        @keyframes pulseGlow {
            0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7); }
            70% { box-shadow: 0 0 0 8px rgba(16, 185, 129, 0); }
            100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
        }

        .logo-box {
            width: 72px;
            height: 72px;
            margin: 0 auto 16px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-radius: 22px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            font-size: 34px;
            box-shadow: 0 10px 22px rgba(2, 132, 199, 0.3);
            transition: transform 0.3s ease;
        }

        .login-card:hover .logo-box {
            transform: scale(1.04);
        }

        .brand-header h1 {
            color: var(--text-main);
            font-size: 24px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .brand-header p {
            color: var(--text-muted);
            font-size: 14px;
            margin-top: 4px;
            font-weight: 500;
        }

        /* Error Notification Alert */
        .error-banner {
            background-color: var(--error-bg);
            border: 1px solid var(--error-border);
            color: var(--error-text);
            padding: 14px 16px;
            border-radius: 12px;
            font-size: 13.5px;
            font-weight: 600;
            margin-bottom: 22px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: shakeError 0.4s ease-in-out;
        }

        @keyframes shakeError {
            0%, 100% { transform: translateX(0); }
            20%, 60% { transform: translateX(-6px); }
            40%, 80% { transform: translateX(6px); }
        }

        /* Input Controls & High Visibility Labels */
        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-main);
            font-size: 13.5px;
            font-weight: 700;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper i.field-icon {
            position: absolute;
            left: 16px;
            color: var(--text-muted);
            font-size: 16px;
            transition: color 0.2s ease;
        }

        .input-wrapper input {
            width: 100%;
            padding: 14px 44px 14px 46px;
            background-color: var(--input-bg);
            border: 2px solid var(--input-border);
            border-radius: 12px;
            font-size: 14.5px;
            font-weight: 500;
            color: var(--text-main);
            outline: none;
            transition: all 0.2s ease;
        }

        .input-wrapper input:focus {
            border-color: var(--primary);
            background-color: #ffffff;
            box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.12);
        }

        .input-wrapper input:focus + i.field-icon {
            color: var(--primary);
        }

        .toggle-pwd {
            position: absolute;
            right: 16px;
            color: var(--text-muted);
            cursor: pointer;
            padding: 4px;
            font-size: 15px;
            transition: color 0.2s ease;
        }

        .toggle-pwd:hover {
            color: var(--text-main);
        }

        /* Action Button */
        .btn-submit {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--primary), var(--primary-hover));
            color: #ffffff;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.25s ease;
            box-shadow: 0 8px 16px rgba(2, 132, 199, 0.25);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 20px rgba(2, 132, 199, 0.35);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        /* Card Footer */
        .card-footer {
            margin-top: 26px;
            text-align: center;
            font-size: 12px;
            color: var(--text-muted);
            border-top: 1px solid #f1f5f9;
            padding-top: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }
    </style>
</head>

<body>

    <!-- Background Elements -->
    <div class="bg-grid"></div>
    <div class="ecg-container">
        <svg style="width: 100%; height: 100%;" viewBox="0 0 1000 100" preserveAspectRatio="none">
            <path class="ecg-line" d="M0,50 L300,50 L320,15 L340,85 L360,5 L380,95 L400,50 L1000,50" />
        </svg>
    </div>

    <!-- Login Container -->
    <div class="login-card">
        
        <div class="brand-header">
            <div class="live-badge">
                <span class="pulse-dot"></span>
                <span>Système Hospitalier Connecté</span>
            </div>
            
            <div class="logo-box">
                <i class="fa-solid fa-hospital-user"></i>
            </div>
            
            <h1>Portail Médical</h1>
            <p>Accès sécurisé au système d'information</p>
        </div>

        <!-- JSP Error Display -->
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="error-banner">
                <i class="fa-solid fa-circle-exclamation"></i>
                <span>${error}</span>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/auth/login" method="post">

            <input type="hidden" name="csrfToken" value="${csrfToken}">
            <!-- Username Input -->
            <div class="form-group">
                <label for="username">Identifiant / Nom d'utilisateur</label>
                <div class="input-wrapper">
                    <input
                        type="text"
                        id="username"
                        name="username"
                        placeholder="Ex: dr.benali"
                        required
                        autocomplete="off"
                    >
                    <i class="fa-solid fa-user-doctor field-icon"></i>
                </div>
            </div>

            <!-- Password Input -->
            <div class="form-group">
                <label for="password">Mot de passe</label>
                <div class="input-wrapper">
                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="••••••••"
                        required
                    >
                    <i class="fa-solid fa-lock field-icon"></i>
                    <i class="fa-solid fa-eye toggle-pwd" id="pwdToggle" title="Afficher/Masquer le mot de passe"></i>
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn-submit">
                <span>Se connecter</span>
                <i class="fa-solid fa-right-to-bracket"></i>
            </button>

        </form>

        <div class="card-footer">
            <i class="fa-solid fa-shield-halved"></i>
            <span>Connexion sécurisée SSL 256-bit</span>
        </div>

    </div>

    <script>
        // Password Visibility Toggle Logic
        const pwdToggle = document.getElementById('pwdToggle');
        const passwordInput = document.getElementById('password');

        pwdToggle.addEventListener('click', () => {
            const isPassword = passwordInput.getAttribute('type') === 'password';
            passwordInput.setAttribute('type', isPassword ? 'text' : 'password');
            pwdToggle.classList.toggle('fa-eye', !isPassword);
            pwdToggle.classList.toggle('fa-eye-slash', isPassword);
        });
    </script>

</body>
</html>