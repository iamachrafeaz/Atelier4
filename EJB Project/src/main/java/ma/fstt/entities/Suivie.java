package ma.fstt.entities;

import jakarta.persistence.*;


import java.io.Serializable;
import java.time.LocalDate;

@Entity
@Table(name = "Suivie",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"id_etudiant", "id_module"})
        }
)
public class Suivie implements Serializable {
    public Suivie() {
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_suivie")
    private int id;

    @Column
    private Double note;

    @Column(name = "date_evaluation")
    private LocalDate dateEvaluation;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_etudiant", nullable = false)
    private Etudiant etudiant;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_module", nullable = false)
    private Module module;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Double getNote() {
        return note;
    }

    public void setNote(Double note) {
        this.note = note;
    }

    public LocalDate getDateEvaluation() {
        return dateEvaluation;
    }

    public void setDateEvaluation(LocalDate dateEvaluation) {
        this.dateEvaluation = dateEvaluation;
    }

    public Etudiant getEtudiant() {
        return etudiant;
    }

    public void setEtudiant(Etudiant etudiant) {
        this.etudiant = etudiant;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }
}