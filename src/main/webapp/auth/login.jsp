<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Espace Médical Premium</title>
    
    <!-- Icons & Fonts -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #00d2ff;
            --primary-dark: #0072ff;
            --secondary: #00f2fe;
            --bg-dark: #0a1128;
            --card-bg: rgba(15, 23, 42, 0.65);
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --error-color: #ff4d6d;
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
            background-color: var(--bg-dark);
            overflow: hidden;
            position: relative;
            perspective: 1000px;
        }

        /* Dynamic Medical Glow Mesh Background */
        .glow-mesh {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 1;
            overflow: hidden;
        }

        .orb {
            position: absolute;
            border-radius: 50%;
            filter: blur(90px);
            opacity: 0.45;
            animation: orbFloat 12s infinite alternate ease-in-out;
        }

        .orb-1 {
            width: 450px;
            height: 450px;
            background: #0072ff;
            top: -10%;
            left: -10%;
        }

        .orb-2 {
            width: 400px;
            height: 400px;
            background: #00f2fe;
            bottom: -10%;
            right: -5%;
            animation-delay: -5s;
        }

        .orb-3 {
            width: 300px;
            height: 300px;
            background: #7b2cbf;
            top: 40%;
            left: 50%;
            transform: translate(-50%, -50%);
            animation-delay: -8s;
        }

        @keyframes orbFloat {
            0% { transform: translate(0, 0) scale(1); }
            100% { transform: translate(60px, 40px) scale(1.15); }
        }

        /* Background Animated ECG Vector Line */
        .ecg-svg {
            position: absolute;
            width: 100%;
            height: 200px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 1;
            opacity: 0.15;
            pointer-events: none;
        }

        .ecg-path {
            stroke: var(--primary);
            stroke-width: 3;
            fill: none;
            stroke-dasharray: 1200;
            stroke-dashoffset: 1200;
            animation: dash 4s linear infinite;
        }

        @keyframes dash {
            to { stroke-dashoffset: 0; }
        }

        /* 3D Glassmorphism Login Card */
        .card-container {
            position: relative;
            z-index: 10;
            width: 100%;
            max-width: 440px;
            padding: 2px;
            border-radius: 28px;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.03));
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.5),
                        0 0 40px rgba(0, 210, 255, 0.15);
            transition: transform 0.1s ease-out;
            transform-style: preserve-3d;
        }

        .login-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: 26px;
            padding: 45px 38px;
            position: relative;
            overflow: hidden;
        }

        /* Top Status Bar */
        .status-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            font-size: 11px;
            color: var(--text-muted);
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .status-badge {
            display: flex;
            align-items: center;
            gap: 6px;
            background: rgba(16, 185, 129, 0.1);
            color: #10b981;
            padding: 4px 10px;
            border-radius: 20px;
            border: 1px solid rgba(16, 185, 129, 0.2);
            font-weight: 600;
        }

        .status-dot {
            width: 6px;
            height: 6px;
            background-color: #10b981;
            border-radius: 50%;
            box-shadow: 0 0 8px #10b981;
            animation: pulseDot 1.5s infinite;
        }

        @keyframes pulseDot {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.3; }
        }

        /* Logo and Header */
        .header-box {
            text-align: center;
            margin-bottom: 32px;
        }

        .logo-wrapper {
            position: relative;
            width: 76px;
            height: 76px;
            margin: 0 auto 18px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logo-ring {
            position: absolute;
            inset: 0;
            border-radius: 50%;
            border: 2px dashed rgba(0, 210, 255, 0.5);
            animation: spinRing 20s linear infinite;
        }

        @keyframes spinRing {
            100% { transform: rotate(360deg); }
        }

        .logo-core {
            width: 60px;
            height: 60px;
            border-radius: 18px;
            background: linear-gradient(135deg, var(--primary-dark), var(--primary));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
            color: #ffffff;
            box-shadow: 0 10px 25px rgba(0, 114, 255, 0.4);
        }

        .header-box h1 {
            color: var(--text-main);
            font-size: 24px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .header-box p {
            color: var(--text-muted);
            font-size: 13px;
            margin-top: 6px;
        }

        /* Error Notification */
        .error-card {
            background: rgba(255, 77, 109, 0.1);
            border: 1px solid rgba(255, 77, 109, 0.3);
            border-radius: 14px;
            padding: 12px 16px;
            color: #ff85a1;
            font-size: 13px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: alertShake 0.4s ease-in-out;
        }

        @keyframes alertShake {
            0%, 100% { transform: translateX(0); }
            20%, 60% { transform: translateX(-8px); }
            40%, 80% { transform: translateX(8px); }
        }

        /* Floating Label Input Group */
        .form-group {
            position: relative;
            margin-bottom: 24px;
        }

        .input-box {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-box input {
            width: 100%;
            padding: 16px 45px 16px 48px;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 14px;
            font-size: 14px;
            color: var(--text-main);
            outline: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .input-box input::placeholder {
            color: transparent; /* Used for custom floating label */
        }

        .input-box label {
            position: absolute;
            left: 48px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 14px;
            pointer-events: none;
            transition: all 0.3s ease;
        }

        .input-box i.icon-main {
            position: absolute;
            left: 18px;
            color: var(--text-muted);
            font-size: 17px;
            transition: color 0.3s ease;
        }

        .toggle-password {
            position: absolute;
            right: 16px;
            color: var(--text-muted);
            cursor: pointer;
            padding: 4px;
            transition: color 0.3s ease;
        }

        .toggle-password:hover {
            color: var(--primary);
        }

        /* Input Focus & Filled State Styling */
        .input-box input:focus,
        .input-box input:not(:placeholder-shown) {
            border-color: var(--primary);
            background: rgba(0, 210, 255, 0.05);
            box-shadow: 0 0 20px rgba(0, 210, 255, 0.15);
        }

        .input-box input:focus ~ label,
        .input-box input:not(:placeholder-shown) ~ label {
            top: 0;
            left: 14px;
            font-size: 11px;
            font-weight: 600;
            color: var(--primary);
            background: var(--bg-dark);
            padding: 2px 8px;
            border-radius: 6px;
        }

        .input-box input:focus ~ i.icon-main,
        .input-box input:not(:placeholder-shown) ~ i.icon-main {
            color: var(--primary);
        }

        /* Creative Action Button */
        .btn-submit {
            width: 100%;
            padding: 16px;
            border: none;
            border-radius: 14px;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: #ffffff;
            font-size: 15px;
            font-weight: 700;
            letter-spacing: 0.5px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 10px 25px rgba(0, 114, 255, 0.35);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
        }

        .btn-submit::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }

        .btn-submit:hover::before {
            left: 100%;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 30px rgba(0, 114, 255, 0.5);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        /* Footer */
        .footer-note {
            margin-top: 28px;
            text-align: center;
            font-size: 12px;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }

        .footer-note i {
            color: #10b981;
        }
    </style>
</head>

<body>

    <!-- Dynamic Animated Background Orbs -->
    <div class="glow-mesh">
        <div class="orb orb-1"></div>
        <div class="orb orb-2"></div>
        <div class="orb orb-3"></div>
    </div>

    <!-- Heartbeat Line Vector Background -->
    <svg class="ecg-svg" viewBox="0 0 1000 100">
        <path class="ecg-path" d="M0,50 L300,50 L320,20 L340,80 L360,10 L380,90 L400,50 L1000,50" />
    </svg>

    <!-- 3D Interactive Card -->
    <div class="card-container" id="cardContainer">
        <div class="login-card">
            
            <div class="status-bar">
                <span>Portail V2.4</span>
                <div class="status-badge">
                    <span class="status-dot"></span>
                    <span>Serveur Actif</span>
                </div>
            </div>

            <div class="header-box">
                <div class="logo-wrapper">
                    <div class="logo-ring"></div>
                    <div class="logo-core">
                        <i class="fa-solid fa-notes-medical"></i>
                    </div>
                </div>
                <h1>Espace Médical</h1>
                <p>Authentification sécurisée du personnel</p>
            </div>

            <!-- JSP Error Dynamic Render -->
            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <div class="error-card">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                    <span>${error}</span>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/auth/login" method="post">

                <!-- Input Username -->
                <div class="form-group">
                    <div class="input-box">
                        <input
                            type="text"
                            id="username"
                            name="username"
                            placeholder="Nom d'utilisateur"
                            required
                            autocomplete="off"
                        >
                        <label for="username">Nom d'utilisateur</label>
                        <i class="fa-solid fa-user-doctor icon-main"></i>
                    </div>
                </div>

                <!-- Input Password -->
                <div class="form-group">
                    <div class="input-box">
                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Mot de passe"
                            required
                        >
                        <label for="password">Mot de passe</label>
                        <i class="fa-solid fa-shield-halved icon-main"></i>
                        <i class="fa-solid fa-eye toggle-password" id="togglePassword"></i>
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-submit">
                    <span>Accéder à la Plateforme</span>
                    <i class="fa-solid fa-arrow-right-long"></i>
                </button>

            </form>

            <div class="footer-note">
                <i class="fa-solid fa-lock"></i>
                <span>Connexion sécurisée SSL 256-bit</span>
            </div>

        </div>
    </div>

    <!-- Interactive Scripts -->
    <script>
        // 1. Interactive 3D Card Parallax Effect
        const card = document.getElementById('cardContainer');
        
        document.addEventListener('mousemove', (e) => {
            const xAxis = (window.innerWidth / 2 - e.pageX) / 25;
            const yAxis = (window.innerHeight / 2 - e.pageY) / 25;
            card.style.transform = `rotateY(${xAxis}deg) rotateX(${yAxis}deg)`;
        });

        // Reset Card orientation when mouse leaves
        document.addEventListener('mouseleave', () => {
            card.style.transform = `rotateY(0deg) rotateX(0deg)`;
            card.style.transition = 'transform 0.5s ease';
        });

        document.addEventListener('mouseenter', () => {
            card.style.transition = 'none';
        });

        // 2. Toggle Password Visibility
        const togglePassword = document.getElementById('togglePassword');
        const passwordInput = document.getElementById('password');

        togglePassword.addEventListener('click', () => {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            togglePassword.classList.toggle('fa-eye');
            togglePassword.classList.toggle('fa-eye-slash');
        });
    </script>
</body>
</html>