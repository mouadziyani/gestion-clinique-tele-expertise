package ma.youcode.clinic.feature.consultation.service;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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

public class ConsultationService {

    private ConsultationDao consultationDao;
    private PatientDAO patientDao;
    private UserDao userDao;

    public ConsultationService() {
        consultationDao = new JdbcConsultationDao();
        patientDao = new JdbcPatientDAO();
        userDao = new JdbcUserDao();
    }

    public Map<String, String> create(
            long patientId,
            long doctorId,
            String motif,
            String observations,
            String diagnostic,
            String treatment,
            double cout,
            StatutConsultation statut,
            LocalDateTime dateConsultation
    ) {
        Map<String, String> errors = validateConsultation(
                patientId,
                doctorId,
                motif,
                observations,
                diagnostic,
                treatment,
                cout,
                statut,
                dateConsultation
        );

        if (!errors.isEmpty()) {
            return errors;
        }

        Patient patient = patientDao.findById(patientId);
        User doctor = userDao.findById(doctorId);

        Consultation consultation = new Consultation(
                patient,
                doctor,
                motif,
                observations,
                diagnostic,
                treatment,
                cout,
                statut,
                dateConsultation
        );

        consultationDao.save(consultation);

        return errors;
    }

    private Map<String, String> validateConsultation(
            long patientId,
            long doctorId,
            String motif,
            String observations,
            String diagnostic,
            String treatment,
            double cout,
            StatutConsultation statut,
            LocalDateTime dateConsultation
    ) {
        Map<String, String> errors = new LinkedHashMap<>();

        Patient patient = patientDao.findById(patientId);
        if (patient == null) {
            errors.put("patientId", "Le patient est obligatoire.");
        }

        User doctor = userDao.findById(doctorId);
        if (doctor == null) {
            errors.put("doctorId", "Le médecin est obligatoire.");
        }

        if (motif == null || motif.trim().isEmpty()) {
            errors.put("motif", "Le motif est obligatoire.");
        }

        if (observations == null || observations.trim().isEmpty()) {
            errors.put("observations", "Les observations sont obligatoires.");
        }

        if (diagnostic == null || diagnostic.trim().isEmpty()) {
            errors.put("diagnostic", "Le diagnostic est obligatoire.");
        }

        if (treatment == null || treatment.trim().isEmpty()) {
            errors.put("treatment", "Le traitement est obligatoire.");
        }

        if (cout < 0) {
            errors.put("cout", "Le coût doit être positif.");
        }

        if (statut == null) {
            errors.put("statut", "Le statut est obligatoire.");
        }

        if (dateConsultation == null) {
            errors.put("dateConsultation", "La date de consultation est obligatoire.");
        } else if (dateConsultation.isAfter(LocalDateTime.now())) {
            errors.put("dateConsultation", "La date de consultation ne peut pas être dans le futur.");
        }

        return errors;
    }

    public List<Consultation> getEnCourDoctorConsultation(Long doctorId) {
        return consultationDao.findByStatutEnCourAndDoctor(doctorId);
    }
}