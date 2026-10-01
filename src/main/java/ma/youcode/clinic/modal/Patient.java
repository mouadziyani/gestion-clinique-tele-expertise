package ma.youcode.clinic.modal;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Patient {
    private Long id;

    private String nom;
    private String prenom;
    private LocalDate dateNaissance;
    private String numeroSecuriteSociale;

    private String tensionArterielle;
    private Double frequenceCardiaque;
    private Double temperature;
    private Double frequenceRespiratoire;

    private LocalDateTime dateArrivee;

    public Patient(String nom, String prenom, LocalDate dateNaissance, String numeroSecuriteSociale, String tensionArterielle, Double frequenceCardiaque, Double temperature, Double frequenceRespiratoire, LocalDateTime dateArrivee) {
        this.nom = nom;
        this.prenom = prenom;
        this.dateNaissance = dateNaissance;
        this.numeroSecuriteSociale = numeroSecuriteSociale;
        this.tensionArterielle = tensionArterielle;
        this.frequenceCardiaque = frequenceCardiaque;
        this.temperature = temperature;
        this.frequenceRespiratoire = frequenceRespiratoire;
        this.dateArrivee = dateArrivee;
    }
    public Patient(Long id, String nom, String prenom, LocalDate dateNaissance, String numeroSecuriteSociale, String tensionArterielle, Double frequenceCardiaque, Double temperature, Double frequenceRespiratoire, LocalDateTime dateArrivee) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.dateNaissance = dateNaissance;
        this.numeroSecuriteSociale = numeroSecuriteSociale;
        this.tensionArterielle = tensionArterielle;
        this.frequenceCardiaque = frequenceCardiaque;
        this.temperature = temperature;
        this.frequenceRespiratoire = frequenceRespiratoire;
        this.dateArrivee = dateArrivee;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public LocalDate getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public String getNumeroSecuriteSociale() {
        return numeroSecuriteSociale;
    }

    public void setNumeroSecuriteSociale(String numeroSecuriteSociale) {
        this.numeroSecuriteSociale = numeroSecuriteSociale;
    }

    public String getTensionArterielle() {
        return tensionArterielle;
    }

    public void setTensionArterielle(String tensionArterielle) {
        this.tensionArterielle = tensionArterielle;
    }

    public Double getFrequenceCardiaque() {
        return frequenceCardiaque;
    }

    public void setFrequenceCardiaque(Double frequenceCardiaque) {
        this.frequenceCardiaque = frequenceCardiaque;
    }

    public Double getTemperature() {
        return temperature;
    }

    public void setTemperature(Double temperature) {
        this.temperature = temperature;
    }

    public Double getFrequenceRespiratoire() {
        return frequenceRespiratoire;
    }

    public void setFrequenceRespiratoire(Double frequenceRespiratoire) {
        this.frequenceRespiratoire = frequenceRespiratoire;
    }

    public LocalDateTime getDateArrivee() {
        return dateArrivee;
    }

    public void setDateArrivee(LocalDateTime dateArrivee) {
        this.dateArrivee = dateArrivee;
    }
}
