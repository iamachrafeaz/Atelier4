package ma.fstt.services;

import jakarta.ejb.Remote;
import ma.fstt.entities.Etudiant;
import ma.fstt.entities.Module;
import ma.fstt.entities.Suivie;

import java.util.List;

@Remote
public interface GestionScolariteRemote {

    // --- CRUD pour Etudiant ---
    void addEtudiant(Etudiant etudiant);
    Etudiant getEtudiant(int id);
    List<Etudiant> getAllEtudiants();
    void updateEtudiant(Etudiant etudiant);
    void deleteEtudiant(int id);

    // --- CRUD pour Module ---
    void addModule(Module module);
    Module getModule(int id);
    List<Module> getAllModules();
    void updateModule(Module module);
    void deleteModule(int id);

    // --- CRUD pour Suivie (Note) ---
    /**
     * Ajoute une nouvelle note (Suivie) en liant l'étudiant et le module par leurs IDs.
     */
    void addSuivie(Suivie suivie, int etudiantId, int moduleId);

    Suivie getSuivie(int id);
    List<Suivie> getAllSuivies();
    void updateSuivie(Suivie suivie);
    void deleteSuivie(int id);

    // Vous pouvez ajouter des méthodes métier plus spécifiques ici,
    // par exemple: List<Suivie> getNotesByEtudiant(int etudiantId);
}