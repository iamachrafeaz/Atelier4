<%@ page import="ma.fstt.entities.Module" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Formulaire Module</title>
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
            max-width: 400px;
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
    ma.fstt.entities.Module module = (ma.fstt.entities.Module) request.getAttribute("module");
    boolean isEdit = (module != null);
%>

<h1><%= isEdit ? "Modifier Module" : "Ajouter Module" %></h1>

<form action="module" method="post">
    <% if (isEdit) { %>
    <input type="hidden" name="id" value="<%= module.getId() %>" />
    <% } %>

    <label>Nom du Module :</label>
    <input type="text" name="nomModule" value="<%= isEdit ? module.getNomModule() : "" %>" required />

    <input type="submit" value="Enregistrer" />
</form>

<a class="back-link" href="module?action=list">← Retour à la liste</a>

</body>
</html>
