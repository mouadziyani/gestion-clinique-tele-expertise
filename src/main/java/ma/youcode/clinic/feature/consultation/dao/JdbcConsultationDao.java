package ma.youcode.clinic.feature.consultation.dao;

import ma.youcode.clinic.modal.Consultation;

import java.util.List;

public class JdbcConsultationDao implements ConsultationDao {

    @Override
    public void save(Consultation consultation) {

    }

    @Override
    public Consultation findById(int id) {
        return null;
    }

    @Override
    public void delete(int id) {

    }

    @Override
    public List<Consultation> findAll() {
        return List.of();
    }
}
