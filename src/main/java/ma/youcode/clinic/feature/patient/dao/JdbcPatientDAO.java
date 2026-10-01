package ma.youcode.clinic.feature.patient.dao;

import ma.youcode.clinic.config.DatasourceConfig;
import ma.youcode.clinic.modal.Patient;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class JdbcPatientDAO implements PatientDAO {
    @Override
    public void save(Patient patient) {
        String sql = "INSERT INTO patient (nom,prenom,date_naissance,numero_securite_sociale,tension_arterielle,frequence_cardiaque,temperature,frequence_respiratoire,date_arrivee) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (
                Connection connection = DatasourceConfig.getDataSource().getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
        ) {
            statement.setString(1, patient.getNom());
            statement.setString(2, patient.getPrenom());
            statement.setDate(3, java.sql.Date.valueOf(patient.getDateNaissance()));
            statement.setString(4, patient.getNumeroSecuriteSociale());
            statement.setString(5, patient.getTensionArterielle());
            statement.setDouble(6, patient.getFrequenceCardiaque());
            statement.setDouble(7, patient.getTemperature());
            statement.setDouble(8, patient.getFrequenceRespiratoire());
            statement.setTimestamp(9, java.sql.Timestamp.valueOf(patient.getDateArrivee()));

            statement.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Error : " + e.getMessage());
        }
    }

    @Override
    public Patient findById(long id) {
        String sql = "SELECT * FROM patient WHERE id = ?";

        try (
                Connection connection = DatasourceConfig.getDataSource().getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);) {

            statement.setLong(1, id);

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
                            result.getTimestamp("date_arrivee").toLocalDateTime());
                }
            }

        } catch (SQLException e) {
            System.err.println("Error : " + e.getMessage());
        }
        return null;
    }

    @Override
    public void delete(long id) {

    }

    @Override
    public List<Patient> findAll() {
        return List.of();
    }

    @Override
    public List<Patient> findPatientsByDay(LocalDate date) {
        String sql = """
                SELECT *
                FROM patient
                WHERE DATE(date_arrivee) = ?
                ORDER BY date_arrivee ASC
                """;

        List<Patient> patients = new ArrayList<>();

        try (
                Connection connection = DatasourceConfig.getDataSource().getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setDate(1, java.sql.Date.valueOf(date));

            try (ResultSet result = stmt.executeQuery()) {
                while (result.next()) {
                    Patient patient = new Patient(
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

                    patients.add(patient);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error : " + e.getMessage());
        }

        return patients;
    }
}
