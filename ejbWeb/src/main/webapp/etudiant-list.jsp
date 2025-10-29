<%@ page import="java.util.*, ma.fstt.entities.Etudiant" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Liste des Étudiants</title>
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
      width: 90%;
      margin: 20px auto;
      border-collapse: collapse;
      background: white;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
      border-radius: 6px;
      overflow: hidden;
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
      margin: 10px 0 20px 5%;
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

<h1>Liste des Étudiants</h1>

<a class="add-btn" href="etudiant?action=new">+ Ajouter un étudiant</a>

<table>
  <thead>
  <tr>
    <th>ID</th>
    <th>CNE</th>
    <th>Nom</th>
    <th>Prénom</th>
    <th>Niveau</th>
    <th>Actions</th>
  </tr>
  </thead>
  <tbody>
  <%
    List<Etudiant> etudiants = (List<Etudiant>) request.getAttribute("etudiants");
    if (etudiants != null && !etudiants.isEmpty()) {
      for (Etudiant e : etudiants) {
  %>
  <tr>
    <td><%= e.getId() %></td>
    <td><%= e.getCne() %></td>
    <td><%= e.getNom() %></td>
    <td><%= e.getPrenom() %></td>
    <td><%= e.getNiveau() %></td>
    <td class="actions">
      <a href="etudiant?action=edit&id=<%= e.getId() %>">Modifier</a>
      <a href="etudiant?action=delete&id=<%= e.getId() %>" onclick="return confirm('Confirmer la suppression ?');">Supprimer</a>
    </td>
  </tr>
  <%
    }
  } else {
  %>
  <tr><td colspan="6" style="text-align:center;">Aucun étudiant trouvé</td></tr>
  <%
    }
  %>
  </tbody>
</table>

</body>
</html>
