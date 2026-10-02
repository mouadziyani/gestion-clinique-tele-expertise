package ma.youcode.clinic.feature.patient.service;

import ma.youcode.clinic.feature.auth.dao.JdbcUserDao;
import ma.youcode.clinic.feature.auth.dao.UserDao;
import ma.youcode.clinic.feature.consultation.dao.ConsultationDao;
import ma.youcode.clinic.feature.consultation.dao.JdbcConsultationDao;
import ma.youcode.clinic.feature.patient.dao.JdbcPatientDAO;
import ma.youcode.clinic.feature.patient.dao.PatientDAO;
import ma.youcode.clinic.modal.Consultation;
import ma.youcode.clinic.modal.Patient;
import ma.youcode.clinic.modal.User;
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
    private UserDao userDao;

    public PatientService() {
        patientDAO = new JdbcPatientDAO();
        consultationDao = new JdbcConsultationDao();
        userDao = new JdbcUserDao();
    }

    public Map<String, String> createPatient(
            String nom,
            String prenom,
            String dateNaissance,
            String numeroSecuriteSociale,
            String tensionArterielle,
            Double frequenceCardiaque,
            Double temperature,
            Double frequenceRespiratoire,
            String motif,
            Long doctorId
    ) {

        Map<String, String> errors = validatePatient(
                nom,
                prenom,
                dateNaissance,
                numeroSecuriteSociale,
                tensionArterielle,
                frequenceCardiaque,
                temperature,
                frequenceRespiratoire,
                motif,
                doctorId
        );

        if (errors.isEmpty()) {

            LocalDate dN = LocalDate.parse(dateNaissance);

            User doctor = userDao.findById(doctorId);

            Patient patient = new Patient(
                    nom,
                    prenom,
                    dN,
                    numeroSecuriteSociale,
                    tensionArterielle,
                    frequenceCardiaque,
                    temperature,
                    frequenceRespiratoire,
                    LocalDateTime.now()
            );

            patientDAO.save(patient);

            Consultation consultation = new Consultation(
                    patient,
                    doctor,
                    motif,
                    null,
                    null,
                    null,
                    null,
                    StatutConsultation.EN_COURS,
                    LocalDateTime.now()
            );

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
            Double frequenceRespiratoire,
            String motif,
            Long doctorId
    ) {
        Map<String, String> errors = new LinkedHashMap<>();

        if (nom == null || nom.isBlank()) {
            errors.put("nom", "Le nom est obligatoire.");
        }

        if (prenom == null || prenom.isBlank()) {
            errors.put("prenom", "Le prénom est obligatoire.");
        }

        try {
            LocalDate dN = LocalDate.parse(dateNaissance);

            if (dN.isAfter(LocalDate.now())) {
                errors.put(
                        "dateNaissance",
                        "La date de naissance ne peut pas être dans le futur."
                );
            }
        } catch (DateTimeParseException | NullPointerException e) {
            errors.put(
                    "dateNaissance",
                    "La date de naissance est invalide."
            );
        }

        if (numeroSecuriteSociale == null ||
                !numeroSecuriteSociale.matches("\\d{7}")) {

            errors.put(
                    "numeroSecuriteSociale",
                    "Le numéro de sécurité sociale doit contenir 7 chiffres."
            );
        }

        if (tensionArterielle == null ||
                !tensionArterielle.matches("\\d{2,3}/\\d{2,3}")) {

            errors.put(
                    "tensionArterielle",
                    "Format attendu : 120/80."
            );
        }

        if (frequenceCardiaque == null ||
                frequenceCardiaque < 20 ||
                frequenceCardiaque > 250) {

            errors.put(
                    "frequenceCardiaque",
                    "Fréquence cardiaque invalide."
            );
        }

        if (temperature == null ||
                temperature < 25 ||
                temperature > 45) {

            errors.put(
                    "temperature",
                    "Température invalide."
            );
        }

        if (frequenceRespiratoire == null ||
                frequenceRespiratoire < 1 ||
                frequenceRespiratoire > 80) {

            errors.put(
                    "frequenceRespiratoire",
                    "Fréquence respiratoire invalide."
            );
        }

        if (motif == null || motif.isBlank()) {
            errors.put(
                    "motif",
                    "Le motif de consultation est obligatoire."
            );
        }

        if (doctorId == null) {

            errors.put(
                    "doctorId",
                    "Veuillez sélectionner un médecin."
            );

        } else {

            try {
                User doctor = userDao.findById(doctorId);

                if (doctor == null) {
                    errors.put(
                            "doctorId",
                            "Le médecin sélectionné n'existe pas."
                    );
                }

            } catch (Exception e) {
                errors.put(
                        "doctorId",
                        "Le médecin sélectionné n'existe pas."
                );
            }
        }

        return errors;
    }

    public List<Patient> findPatientsDuJour(LocalDate date) {
        return patientDAO.findPatientsByDay(date);
    }

    private void createPatientConsultation(Consultation consultation) {
        consultationDao.save(consultation);
    }
}
