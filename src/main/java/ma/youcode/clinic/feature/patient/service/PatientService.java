package ma.youcode.clinic.feature.patient.service;

import ma.youcode.clinic.feature.patient.dao.JdbcPatientDAO;
import ma.youcode.clinic.feature.patient.dao.PatientDAO;
import ma.youcode.clinic.modal.Patient;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.LinkedHashMap;
import java.util.Map;

public class PatientService {
    private PatientDAO patientDAO;

    public PatientService() {
        patientDAO = new JdbcPatientDAO();
    }

    public void createPatient(
            String nom,
            String prenom,
            LocalDate dateNaissance,
            String numeroSecuriteSociale,
            String tensionArterielle,
            Double frequenceCardiaque,
            Double temperature,
            Double frequenceRespiratoire
    ) {

    }

    public Patient findById(Long id) {
        return patientDAO.findById(id);
    }

    private Map<String, String> validatePatient(
            String nom,
            String prenom,
            LocalDate dateNaissance,
            String numeroSecuriteSociale,
            String tensionArterielle,
            Double frequenceCardiaque,
            Double temperature,
            Double frequenceRespiratoire
    ) {
        Map<String, String> errors = new LinkedHashMap<>();

        if (nom.isEmpty()) errors.put("nom", "Le nom est obligatoire.");

        if (prenom.isEmpty()) errors.put("prenom", "Le prénom est obligatoire.");

        try {
            if (dateNaissance.isAfter(LocalDate.now())) {
                errors.put("dateNaissance", "La date de naissance ne peut pas être dans le futur.");
            }
        } catch (DateTimeParseException e) {
            errors.put("dateNaissance", "La date de naissance est invalide.");
        }

        if (!numeroSecuriteSociale.matches("\\d{7}")) errors.put("numeroSecuriteSociale", "Le numéro de sécurité sociale doit contenir 15 chiffres.");

        if (!tensionArterielle.matches("\\d{2,3}/\\d{2,3}")) errors.put("tensionArterielle", "Format attendu : 120/80.");

        if (frequenceCardiaque < 20 || frequenceCardiaque > 250) errors.put("frequenceCardiaque" , "Fréquence cardiaque invalide");

        if (temperature < 25 || temperature > 45) errors.put("temperature" , "Temperature invalide");

        if (frequenceRespiratoire < 1 || frequenceRespiratoire > 80) errors.put("frequenceRespiratoire" , "Fréquence respiratoir invalide");
    }
}
