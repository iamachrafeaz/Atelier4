package ma.fstt.controllers;

import ma.fstt.entities.Etudiant;
import ma.fstt.entities.Module;
import ma.fstt.entities.Suivie;
import ma.fstt.services.GestionScolariteRemote;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "SuivieController", urlPatterns = {"/suivie"})
public class SuivieController extends HttpServlet {

    @EJB(lookup = "java:global/ejbProject-1.0-SNAPSHOT/GestionScolariteEJB!ma.fstt.services.GestionScolariteRemote")
    private GestionScolariteRemote scolariteService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                // Load students and modules for the <select> dropdowns in the form
                loadFormDependencies(request);
                request.getRequestDispatcher("/suivie-form.jsp").forward(request, response);
                break;
            case "edit":
                // Load the existing note
                int id = Integer.parseInt(request.getParameter("id"));
                Suivie suivie = scolariteService.getSuivie(id);
                request.setAttribute("suivie", suivie);
                // Also load students and modules for dropdowns
                loadFormDependencies(request);
                request.getRequestDispatcher("/suivie-form.jsp").forward(request, response);
                break;
            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                scolariteService.deleteSuivie(deleteId);
                response.sendRedirect("suivie?action=list");
                break;
            case "list":
            default:
                request.setAttribute("suivies", scolariteService.getAllSuivies());
                request.getRequestDispatcher("/suivie-list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");

        // Retrieve form data
        double note = Double.parseDouble(request.getParameter("note"));
        LocalDate date = LocalDate.parse(request.getParameter("dateEvaluation"));
        int etudiantId = Integer.parseInt(request.getParameter("id_etudiant"));
        int moduleId = Integer.parseInt(request.getParameter("id_module"));

        Suivie suivie = new Suivie();
        suivie.setNote(note);
        suivie.setDateEvaluation(date);

        if (idStr == null || idStr.isEmpty()) {
            // Create new Suivie (Note) using the special EJB method
            scolariteService.addSuivie(suivie, etudiantId, moduleId);
        } else {
            // Update existing Suivie
            suivie.setId(Integer.parseInt(idStr));
            // We must re-associate the Etudiant and Module entities
            Etudiant etudiant = scolariteService.getEtudiant(etudiantId);
            Module module = scolariteService.getModule(moduleId);
            suivie.setEtudiant(etudiant);
            suivie.setModule(module);
            scolariteService.updateSuivie(suivie);
        }

        response.sendRedirect("suivie?action=list");
    }

    /**
     * Helper method to load Etudiant and Module lists into the request
     * for the 'new' and 'edit' forms.
     */
    private void loadFormDependencies(HttpServletRequest request) {
        request.setAttribute("etudiants", scolariteService.getAllEtudiants());
        request.setAttribute("modules", scolariteService.getAllModules());
    }
}