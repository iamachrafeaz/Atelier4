<%@ page import="java.util.*, ma.fstt.entities.Suivie" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Liste des Notes (Suivies)</title>
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

<h1>Liste des Notes (Suivies)</h1>

<a class="add-btn" href="suivie?action=new">+ Ajouter une note</a>

<table>
  <thead>
  <tr>
    <th>ID Note</th>
    <th>Étudiant</th>
    <th>Module</th>
    <th>Note</th>
    <th>Date</th>
    <th>Actions</th>
  </tr>
  </thead>
  <tbody>
  <%
    List<Suivie> suivies = (List<Suivie>) request.getAttribute("suivies");
    if (suivies != null && !suivies.isEmpty()) {
      for (Suivie s : suivies) {
  %>
  <tr>
    <td><%= s.getId() %></td>
    <td>
      <%= s.getEtudiant() != null ? s.getEtudiant().getNom() + " " + s.getEtudiant().getPrenom() : "-" %>
    </td>
    <td>
      <%= s.getModule() != null ? s.getModule().getNomModule() : "-" %>
    </td>
    <td><%= s.getNote() %></td>
    <td><%= s.getDateEvaluation() != null ? s.getDateEvaluation().toString() : "-" %></td>
    <td class="actions">
      <a href="suivie?action=edit&id=<%= s.getId() %>">Modifier</a>
      <a href="suivie?action=delete&id=<%= s.getId() %>" onclick="return confirm('Confirmer la suppression ?');">Supprimer</a>
    </td>
  </tr>
  <%
    }
  } else {
  %>
  <tr><td colspan="6" style="text-align:center;">Aucune note trouvée</td></tr>
  <%
    }
  %>
  </tbody>
</table>

</body>
</html>
