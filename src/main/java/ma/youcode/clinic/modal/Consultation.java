package ma.youcode.clinic.modal;

import ma.youcode.clinic.modal.enums.StatutConsultation;

import java.time.LocalDateTime;

public class Consultation {
    private Long id;

    private Patient patient;
    private User doctor;

    private String motif;
    private String observations;
    private String diagnostic;
    private String treatment;

    private Double cout;
    private StatutConsultation statut;

    private LocalDateTime dateConsultation;

    public Consultation(Long id, Patient patient, User doctor, String motif, String observations, String diagnostic, String treatment, Double cout, StatutConsultation statut, LocalDateTime dateConsultation) {
        this.id = id;
        this.patient = patient;
        this.doctor = doctor;
        this.motif = motif;
        this.observations = observations;
        this.diagnostic = diagnostic;
        this.treatment = treatment;
        this.cout = cout;
        this.statut = statut;
        this.dateConsultation = dateConsultation;
    }
    public Consultation( Patient patient, User doctor, String motif, String observations, String diagnostic, String treatment, Double cout, StatutConsultation statut, LocalDateTime dateConsultation) {

        this.patient = patient;
        this.doctor = doctor;
        this.motif = motif;
        this.observations = observations;
        this.diagnostic = diagnostic;
        this.treatment = treatment;
        this.cout = cout;
        this.statut = statut;
        this.dateConsultation = dateConsultation;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public User getDoctor() {
        return doctor;
    }

    public void setDoctor(User doctor) {
        this.doctor = doctor;
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public String getObservations() {
        return observations;
    }

    public void setObservations(String observations) {
        this.observations = observations;
    }

    public String getDiagnostic() {
        return diagnostic;
    }

    public void setDiagnostic(String diagnostic) {
        this.diagnostic = diagnostic;
    }

    public String getTreatment() {
        return treatment;
    }

    public void setTreatment(String treatment) {
        this.treatment = treatment;
    }

    public Double getCout() {
        return cout;
    }

    public void setCout(Double cout) {
        this.cout = cout;
    }

    public StatutConsultation getStatut() {
        return statut;
    }

    public void setStatut(StatutConsultation statut) {
        this.statut = statut;
    }

    public LocalDateTime getDateConsultation() {
        return dateConsultation;
    }

    public void setDateConsultation(LocalDateTime dateConsultation) {
        this.dateConsultation = dateConsultation;
    }
}
