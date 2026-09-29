package ma.youcode.clinic.feature.consultation.dao;

import ma.youcode.clinic.config.DatasourceConfig;
import ma.youcode.clinic.modal.Consultation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class JdbcConsultationDao implements ConsultationDao {

    @Override
    public void save(Consultation consultation) {
        String sql = "INSERT INTO consultation (patient_id , doctor_id , motif , observations , diagnostic , treatment , cout , statut) VALUES (? , ? , ? , ? , ? , ? , ? , ?)";

        try (
                Connection connection = DatasourceConfig.getDataSource().getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ) {

            statement.setLong(1, consultation.getPatient().getId());
            statement.setLong(2, consultation.getDoctor().getId());
            statement.setString(3, consultation.getMotif());
            statement.setString(4, consultation.getObservations());
            statement.setString(5, consultation.getDiagnostic());
            statement.setString(6, consultation.getTreatment());
            statement.setDouble(7, consultation.getCout());
            statement.setString(8, consultation.getStatut().name());

            statement.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Error : " + e.getMessage());
        }

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
