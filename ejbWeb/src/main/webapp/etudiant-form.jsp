<%@ page import="ma.fstt.entities.Etudiant" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Formulaire Étudiant</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background: #f9fafb;
            color: #333;
        }
        h1 {
            color: #2c3e50;
            text-align: center;
        }
        form {
            max-width: 450px;
            margin: 40px auto;
            padding: 25px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
        }
        input[type="text"] {
            width: 100%;
            padding: 8px 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        input[type="submit"]:hover {
            background: #2980b9;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #3498db;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<%
    Etudiant etudiant = (Etudiant) request.getAttribute("etudiant");
    boolean isEdit = (etudiant != null);
%>

<h1><%= isEdit ? "Modifier Étudiant" : "Ajouter Étudiant" %></h1>

<form action="etudiant" method="post">
    <% if (isEdit) { %>
    <input type="hidden" name="id" value="<%= etudiant.getId() %>" />
    <% } %>

    <label>Nom :</label>
    <input type="text" name="nom" value="<%= isEdit ? etudiant.getNom() : "" %>" required />

    <label>Prénom :</label>
    <input type="text" name="prenom" value="<%= isEdit ? etudiant.getPrenom() : "" %>" required />

    <label>CNE :</label>
    <input type="text" name="cne" value="<%= isEdit ? etudiant.getCne() : "" %>" required />

    <label>Adresse :</label>
    <input type="text" name="adresse" value="<%= isEdit ? etudiant.getAdresse() : "" %>" />

    <label>Niveau :</label>
    <input type="text" name="niveau" value="<%= isEdit ? etudiant.getNiveau() : "" %>" />

    <input type="submit" value="Enregistrer" />
</form>

<a class="back-link" href="etudiant?action=list">← Retour à la liste</a>

</body>
</html>
