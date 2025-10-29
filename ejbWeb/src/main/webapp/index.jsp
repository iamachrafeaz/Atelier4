<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <title>Accueil - Gestion Scolarité</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 40px;
                background: #f9fafb;
                color: #333;
            }

            h1 {
                text-align: center;
                color: #2c3e50;
            }

            h2 {
                margin-top: 40px;
                text-align: center;
                color: #2c3e50;
            }

            .nav-container {
                display: flex;
                justify-content: center;
                gap: 20px;
                flex-wrap: wrap;
                margin-top: 30px;
            }

            .nav-box {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 220px;
                height: 120px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                text-align: center;
                font-size: 1.2em;
                font-weight: bold;
                color: #3498db;
                text-decoration: none;
                transition: transform 0.2s, box-shadow 0.2s;
            }

            .nav-box:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 14px rgba(0, 0, 0, 0.2);
                background: #f4f9ff;
            }
        </style>
    </head>

    <body>

        <h1>Bienvenue sur l'application de Gestion de Scolarité</h1>

        <h2>Navigation Principale :</h2>
        <div class="nav-container">
            <a class="nav-box" href="etudiant?action=list">Gestion des Étudiants</a>
            <a class="nav-box" href="module?action=list">Gestion des Modules</a>
            <a class="nav-box" href="suivie?action=list">Gestion des Notes (Suivies)</a>
        </div>

    </body>

    </html>