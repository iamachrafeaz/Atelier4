package ma.fstt.controllers;

import ma.fstt.entities.Module;
import ma.fstt.services.GestionScolariteRemote;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ModuleController", urlPatterns = {"/module"})
public class ModuleController extends HttpServlet {

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
                request.getRequestDispatcher("/module-form.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Module module = scolariteService.getModule(id);
                request.setAttribute("module", module);
                request.getRequestDispatcher("/module-form.jsp").forward(request, response);
                break;
            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                scolariteService.deleteModule(deleteId);
                response.sendRedirect("module?action=list");
                break;
            case "list":
            default:
                request.setAttribute("modules", scolariteService.getAllModules());
                request.getRequestDispatcher("/module-list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");

        Module module = new Module();
        module.setNomModule(request.getParameter("nomModule"));

        if (idStr == null || idStr.isEmpty()) {
            // Create new Module
            scolariteService.addModule(module);
        } else {
            // Update existing Module
            module.setId(Integer.parseInt(idStr));
            scolariteService.updateModule(module);
        }

        response.sendRedirect("module?action=list");
    }
}