package ma.youcode.clinic.feature.patient.dao;

import ma.youcode.clinic.config.DatasourceConfig;
import ma.youcode.clinic.modal.Patient;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class JdbcPatientDAO implements PatientDAO {
    @Override
    public void save(Patient patient) {

    }

    @Override
    public Patient findById(long id) {
        String sql = "SELECT * FROM patient WHERE id = ?";

        try (
                Connection connection = DatasourceConfig.getDataSource().getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ) {

            statement.setLong(1 , id);

            try (ResultSet result = statement.executeQuery()) {
                 if (result.next()) {
                     return new Patient(
                             result.getLong("id"),
                             result.getString("nom"),
                             result.getString("prenom"),
                             result.getDate("date_naissance").toLocalDate(),
                             result.getString("numero_securite_sociale"),
                             result.getString("tension_arterielle"),
                             result.getDouble("frequence_cardiaque"),
                             result.getDouble("temperature"),
                             result.getDouble("frequence_respiratoire"),
                             result.getTimestamp("date_arrivee").toLocalDateTime()
                     );
                 }
            }

        } catch (SQLException e) {
            System.err.println("Error : " + e.getMessage());
        }
        return null;
    }

    @Override
    public void delete(int id) {

    }

    @Override
    public List<Patient> findAll() {
        return List.of();
    }
}
