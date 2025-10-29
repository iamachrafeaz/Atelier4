<%@ page import="java.util.*, ma.fstt.entities.Suivie, ma.fstt.entities.Etudiant, ma.fstt.entities.Module" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Formulaire Note (Suivie)</title>
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
        input[type="text"], input[type="number"], input[type="date"], select {
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
    Suivie suivie = (Suivie) request.getAttribute("suivie");
    List<Etudiant> etudiants = (List<Etudiant>) request.getAttribute("etudiants");
    List<Module> modules = (List<Module>) request.getAttribute("modules");
    boolean isEdit = (suivie != null);
%>

<h1><%= isEdit ? "Modifier Note" : "Ajouter Note" %></h1>

<form action="suivie" method="post">
    <% if (isEdit) { %>
    <input type="hidden" name="id" value="<%= suivie.getId() %>" />
    <% } %>

    <label>Étudiant :</label>
    <select name="id_etudiant" required>
        <%
            if (etudiants != null) {
                for (Etudiant e : etudiants) {
                    boolean selected = isEdit && suivie.getEtudiant() != null && suivie.getEtudiant().getId() == (e.getId());
        %>
        <option value="<%= e.getId() %>" <%= selected ? "selected" : "" %>>
            <%= e.getNom() %> <%= e.getPrenom() %>
        </option>
        <%
                }
            }
        %>
    </select>

    <label>Module :</label>
    <select name="id_module" required>
        <%
            if (modules != null) {
                for (Module m : modules) {
                    boolean selected = isEdit && suivie.getModule() != null && suivie.getModule().getId() == (m.getId());
        %>
        <option value="<%= m.getId() %>" <%= selected ? "selected" : "" %>>
            <%= m.getNomModule() %>
        </option>
        <%
                }
            }
        %>
    </select>

    <label>Note :</label>
    <input type="number" step="0.01" name="note" value="<%= isEdit ? suivie.getNote() : "" %>" required />

    <label>Date d'Évaluation :</label>
    <input type="date" name="dateEvaluation" value="<%= isEdit && suivie.getDateEvaluation() != null ? suivie.getDateEvaluation().toString() : "" %>" required />

    <input type="submit" value="Enregistrer" />
</form>

<a class="back-link" href="suivie?action=list">← Retour à la liste</a>

</body>
</html>
