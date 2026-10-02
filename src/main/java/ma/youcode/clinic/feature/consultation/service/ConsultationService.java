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

    public Map<String, String> update(
            long consultationId,
            String observations,
            String diagnostic,
            String treatment,
            double cout,
            StatutConsultation statut
    ) {
        Map<String, String> errors = validateConsultationUpdate(
                observations,
                diagnostic,
                treatment,
                cout,
                statut
        );

        if (!errors.isEmpty()) {
            return errors;
        }

        Consultation consultation = consultationDao.findById(consultationId);

        if (consultation == null) {
            errors.put("consultation", "La consultation n'existe pas.");
            return errors;
        }

        consultation.setObservations(observations);
        consultation.setDiagnostic(diagnostic);
        consultation.setTreatment(treatment);
        consultation.setCout(cout);
        consultation.setStatut(statut);

        consultationDao.update(consultation);

        return errors;
    }

    private Map<String, String> validateConsultationUpdate(
            String observations,
            String diagnostic,
            String treatment,
            double cout,
            StatutConsultation statut
    ) {
        Map<String, String> errors = new LinkedHashMap<>();

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

        return errors;
    }

    public List<Consultation> getEnCourDoctorConsultation(Long doctorId) {
        return consultationDao.findByStatutEnCourAndDoctor(doctorId);
    }

    public Consultation findById(Long id) {
        return consultationDao.findById(id);
    }
}