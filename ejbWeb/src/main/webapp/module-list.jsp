<%@ page import="java.util.*, ma.fstt.entities.Module" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Modules</title>
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
        a {
            text-decoration: none;
            color: #3498db;
        }
        a:hover {
            text-decoration: underline;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background: white;
            border-radius: 6px;
            overflow: hidden;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
        }
        th {
            background: #3498db;
            color: white;
        }
        tr:nth-child(even) {
            background: #f2f2f2;
        }
        .actions a {
            margin-right: 8px;
        }
        .add-btn {
            display: inline-block;
            margin: 10px 0 20px 10%;
            background: #2ecc71;
            color: white;
            padding: 8px 14px;
            border-radius: 4px;
        }
        .add-btn:hover {
            background: #27ae60;
        }
    </style>
</head>
<body>

<h1>Liste des Modules</h1>

<a class="add-btn" href="module?action=new">+ Ajouter un module</a>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Nom du Module</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Module> modules = (List<Module>) request.getAttribute("modules");
        if (modules != null && !modules.isEmpty()) {
            for (Module m : modules) {
    %>
    <tr>
        <td><%= m.getId() %></td>
        <td><%= m.getNomModule() %></td>
        <td class="actions">
            <a href="module?action=edit&id=<%= m.getId() %>">Modifier</a>
            <a href="module?action=delete&id=<%= m.getId() %>" onclick="return confirm('Confirmer la suppression ?');">Supprimer</a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="3" style="text-align:center;">Aucun module trouvé</td></tr>
    <%
        }
    %>
    </tbody>
</table>

</body>
</html>
