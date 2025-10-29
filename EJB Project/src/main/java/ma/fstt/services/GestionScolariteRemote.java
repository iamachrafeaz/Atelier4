package ma.fstt.services;

import ma.fstt.entities.Etudiant;
import ma.fstt.entities.Module;
import ma.fstt.entities.Suivie;
import jakarta.ejb.Remote;
import java.util.List;

@Remote
public interface GestionScolariteRemote {

    void addEtudiant(Etudiant etudiant);
    Etudiant getEtudiant(int id);
    List<Etudiant> getAllEtudiants();
    void updateEtudiant(Etudiant etudiant);
    void deleteEtudiant(int id);

    void addModule(Module module);
    Module getModule(int id);
    List<Module> getAllModules();
    void updateModule(Module module);
    void deleteModule(int id);

    void addSuivie(Suivie suivie, int etudiantId, int moduleId);

    Suivie getSuivie(int id);
    List<Suivie> getAllSuivies();
    void updateSuivie(Suivie suivie);
    void deleteSuivie(int id);
}