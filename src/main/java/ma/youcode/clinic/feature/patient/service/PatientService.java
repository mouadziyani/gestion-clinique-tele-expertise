package ma.youcode.clinic.feature.patient.service;

import ma.youcode.clinic.feature.patient.dao.JdbcPatientDAO;
import ma.youcode.clinic.feature.patient.dao.PatientDAO;
import ma.youcode.clinic.modal.Patient;

public class PatientService {
    private PatientDAO patientDAO;

    public PatientService() {
        patientDAO = new JdbcPatientDAO();
    }

    public void createPatient(Patient patient) {
        patientDAO.save(patient);
    }

    private void validatePatient() {}
}
