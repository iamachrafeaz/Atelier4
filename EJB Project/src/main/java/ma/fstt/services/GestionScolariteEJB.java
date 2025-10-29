package ma.fstt.services;

import jakarta.ejb.Remote;
import ma.fstt.entities.Etudiant;
import ma.fstt.entities.Module;
import ma.fstt.entities.Suivie;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import java.util.List;

@Stateless
@Remote(GestionScolariteRemote.class)
public class GestionScolariteEJB implements GestionScolariteRemote {

    @PersistenceContext(unitName = "cnx")
    private EntityManager entityManager;


    @Override
    public void addEtudiant(Etudiant etudiant) {
        System.out.println("BACK feoihfoeihfoie  : " + etudiant.getNom());
        entityManager.persist(etudiant);
    }

    @Override
    public Etudiant getEtudiant(int id) {
        return entityManager.find(Etudiant.class, id);
    }

    @Override
    public List<Etudiant> getAllEtudiants() {
        TypedQuery<Etudiant> query = entityManager.createQuery("SELECT e FROM Etudiant e", Etudiant.class);
        return query.getResultList();
    }

    @Override
    public void updateEtudiant(Etudiant etudiant) {
        entityManager.merge(etudiant);
    }

    @Override
    public void deleteEtudiant(int id) {
        Etudiant etudiant = entityManager.find(Etudiant.class, id);
        if (etudiant != null) {
            entityManager.remove(etudiant);
        }
    }

    @Override
    public void addModule(Module module) {
        entityManager.persist(module);
    }

    @Override
    public Module getModule(int id) {
        return entityManager.find(Module.class, id);
    }

    @Override
    public List<Module> getAllModules() {
        TypedQuery<Module> query = entityManager.createQuery("SELECT m FROM Module m", Module.class);
        return query.getResultList();
    }

    @Override
    public void updateModule(Module module) {
        entityManager.merge(module);
    }

    @Override
    public void deleteModule(int id) {
        Module module = entityManager.find(Module.class, id);
        if (module != null) {
            entityManager.remove(module);
        }
    }

    @Override
    public void addSuivie(Suivie suivie, int etudiantId, int moduleId) {
        Etudiant etudiant = entityManager.find(Etudiant.class, etudiantId);
        Module module = entityManager.find(Module.class, moduleId);

        if (etudiant != null && module != null) {
            suivie.setEtudiant(etudiant);
            suivie.setModule(module);
            entityManager.persist(suivie);
        }
    }

    @Override
    public Suivie getSuivie(int id) {
        return entityManager.find(Suivie.class, id);
    }

    @Override
    public List<Suivie> getAllSuivies() {
        TypedQuery<Suivie> query = entityManager.createQuery("SELECT s FROM Suivie s", Suivie.class);
        return query.getResultList();
    }

    @Override
    public void updateSuivie(Suivie suivie) {
        entityManager.merge(suivie);
    }

    @Override
    public void deleteSuivie(int id) {
        Suivie suivie = entityManager.find(Suivie.class, id);
        if (suivie != null) {
            entityManager.remove(suivie);
        }
    }
}