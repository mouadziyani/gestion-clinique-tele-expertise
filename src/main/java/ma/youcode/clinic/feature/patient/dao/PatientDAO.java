package ma.youcode.clinic.feature.patient.dao;

import java.time.LocalDate;
import java.util.List;

import ma.youcode.clinic.dao.Dao;
import ma.youcode.clinic.modal.Patient;

public interface PatientDAO extends Dao<Patient> {
    List<Patient> findPatientsByDay(LocalDate date);
}
