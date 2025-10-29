package ma.fstt.controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.fstt.entities.Etudiant;
import ma.fstt.services.GestionScolariteRemote;

import java.io.IOException;

@WebServlet(name = "EtudiantController", urlPatterns = {"/etudiant"})
public class EtudiantController extends HttpServlet {

    @EJB(lookup = "java:global/ejbProject-1.0-SNAPSHOT/GestionScolariteEJB!ma.fstt.services.GestionScolariteRemote")
    private GestionScolariteRemote scolariteService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "new":
                // Show the form to create a new student
                request.getRequestDispatcher("/etudiant-form.jsp").forward(request, response);
                break;
            case "edit":
                // Show the form to edit an existing student
                int id = Integer.parseInt(request.getParameter("id"));
                Etudiant etudiant = scolariteService.getEtudiant(id);
                request.setAttribute("etudiant", etudiant);
                request.getRequestDispatcher("/etudiant-form.jsp").forward(request, response);
                break;
            case "delete":
                // Delete the student and redirect to the list
                int deleteId = Integer.parseInt(request.getParameter("id"));
                scolariteService.deleteEtudiant(deleteId);
                response.sendRedirect("etudiant?action=list");
                break;
            case "list":
            default:
                // List all students
                request.setAttribute("etudiants", scolariteService.getAllEtudiants());
                request.getRequestDispatcher("/etudiant-list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle the form submission for both create and update

        String idStr = request.getParameter("id");

        Etudiant etudiant = new Etudiant();
        etudiant.setNom(request.getParameter("nom"));
        etudiant.setPrenom(request.getParameter("prenom"));
        etudiant.setCne(request.getParameter("cne"));
        etudiant.setAdresse(request.getParameter("adresse"));
        etudiant.setNiveau(request.getParameter("niveau"));


        if (idStr == null || idStr.isEmpty()) {
            // Create new Etudiant
            scolariteService.addEtudiant(etudiant);
        } else {
            // Update existing Etudiant
            etudiant.setId(Integer.parseInt(idStr));
            scolariteService.updateEtudiant(etudiant);
        }

        // Redirect to the list view (Post-Redirect-Get pattern)
        response.sendRedirect("etudiant?action=list");
    }
}
