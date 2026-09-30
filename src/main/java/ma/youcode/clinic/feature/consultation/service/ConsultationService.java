package ma.youcode.clinic.feature.consultation.service;

import ma.youcode.clinic.feature.consultation.dao.ConsultationDao;
import ma.youcode.clinic.feature.consultation.dao.JdbcConsultationDao;
import ma.youcode.clinic.modal.Consultation;

public class ConsultationService {
    
    private ConsultationDao consultationDao;

    public ConsultationService() {
        consultationDao = new JdbcConsultationDao();
    }

    public void create(Consultation consultation) {
        if (consultation == null) {
            return;
        }

        if (consultation.getPatient() == null) {
            return;
        }

        if (consultation.getDoctor() == null) {
            return;
        }

        consultationDao.save(consultation);
    }

}
