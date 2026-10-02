package ma.youcode.clinic.feature.patient.service;

import ma.youcode.clinic.feature.consultation.dao.ConsultationDao;
import ma.youcode.clinic.feature.consultation.dao.JdbcConsultationDao;
import ma.youcode.clinic.feature.consultation.service.ConsultationService;
import ma.youcode.clinic.feature.patient.dao.JdbcPatientDAO;
import ma.youcode.clinic.feature.patient.dao.PatientDAO;
import ma.youcode.clinic.modal.Consultation;
import ma.youcode.clinic.modal.Patient;
import ma.youcode.clinic.modal.enums.StatutConsultation;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class PatientService {
    private PatientDAO patientDAO;
    private ConsultationDao consultationDao;

    public PatientService() {
        patientDAO = new JdbcPatientDAO();
        consultationDao = new JdbcConsultationDao();
    }

    public Map<String , String> createPatient(
            String nom,
            String prenom,
            String dateNaissance,
            String numeroSecuriteSociale,
            String tensionArterielle,
            Double frequenceCardiaque,
            Double temperature,
            Double frequenceRespiratoire
    ) {
        Map<String , String> errors = validatePatient(nom, prenom, dateNaissance, numeroSecuriteSociale, tensionArterielle, frequenceCardiaque, temperature, frequenceRespiratoire);


        if (errors.isEmpty()) {
            LocalDate dN = LocalDate.parse(dateNaissance);

            Patient patient = new Patient(nom , prenom , dN ,numeroSecuriteSociale , tensionArterielle , frequenceCardiaque , temperature , frequenceRespiratoire , LocalDateTime.now());

            patientDAO.save(patient);

            Consultation consultation = new Consultation(patient , null , null , null , null , null , null , StatutConsultation.EN_COURS , LocalDateTime.now());

            createPatientConsultation(consultation);
        }
        return errors;
    }

    public Patient findById(Long id) {
        return patientDAO.findById(id);
    }

    private Map<String, String> validatePatient(
            String nom,
            String prenom,
            String dateNaissance,
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
            LocalDate dN = LocalDate.parse(dateNaissance);

            if (dN.isAfter(LocalDate.now())) {
                errors.put("dateNaissance", "La date de naissance ne peut pas être dans le futur.");
            }
        } catch (DateTimeParseException e) {
            errors.put("dateNaissance", "La date de naissance est invalide.");
        }

        if (!numeroSecuriteSociale.matches("\\d{7}")) errors.put("numeroSecuriteSociale", "Le numéro de sécurité sociale doit contenir 7 chiffres.");

        if (!tensionArterielle.matches("\\d{2,3}/\\d{2,3}")) errors.put("tensionArterielle", "Format attendu : 120/80.");

        if (frequenceCardiaque < 20 || frequenceCardiaque > 250) errors.put("frequenceCardiaque" , "Fréquence cardiaque invalide");

        if (temperature < 25 || temperature > 45) errors.put("temperature" , "Temperature invalide");

        if (frequenceRespiratoire < 1 || frequenceRespiratoire > 80) errors.put("frequenceRespiratoire" , "Fréquence respiratoir invalide");

        return errors;
    }

    public List<Patient> findPatientsDuJour(LocalDate date) {
        return patientDAO.findPatientsByDay(date);
    }

    private void createPatientConsultation(Consultation consultation) {
        consultationDao.save(consultation);
    }
}
