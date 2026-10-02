package ma.youcode.clinic.config;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DatabaseInitializer {
    private final DataSource dataSource;

    public DatabaseInitializer(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public void init() {
        createUserTable();
        createPatientTable();
        createConsultationTable();
    }

    private void createUserTable() {
        String sql = """
                CREATE TABLE IF NOT EXISTS users (
                    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                    username VARCHAR(50) NOT NULL UNIQUE,
                    password VARCHAR(255) NOT NULL,
                    role VARCHAR(30) NOT NULL
                )
                """;

        try (
                Connection connection = dataSource.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
        ) {
            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Error : " + e.getMessage());
        }
    }

    private void createPatientTable() {
        String sql = """
                CREATE TABLE IF NOT EXISTS patients (
                    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                    nom VARCHAR(100) NOT NULL,
                    prenom VARCHAR(100) NOT NULL,
                    date_naissance DATE NOT NULL,
                    numero_securite_sociale VARCHAR(20) NOT NULL UNIQUE,
                    tension_arterielle VARCHAR(10),
                    frequence_cardiaque DOUBLE,
                    temperature DOUBLE,
                    frequence_respiratoire DOUBLE,
                    date_arrivee DATETIME NOT NULL
                )
                """;

        try (
                Connection connection = dataSource.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
        ) {
            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Error : " + e.getMessage());
        }
    }

    private void createConsultationTable() {
        String sql = """
                CREATE TABLE IF NOT EXISTS consultations (
                    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                    patient_id BIGINT NOT NULL,
                    doctor_id BIGINT,
                    motif VARCHAR(255),
                    observations TEXT,
                    diagnostic TEXT,
                    treatment TEXT,
                    cout DECIMAL(10, 2),
                    statut VARCHAR(30) NOT NULL,
                    date_consultation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                    CONSTRAINT fk_consultation_patient FOREIGN KEY (patient_id) REFERENCES patients(id),
                    CONSTRAINT fk_consultation_doctor FOREIGN KEY (doctor_id) REFERENCES `users`(id)
                )
                """;

        try (
                Connection connection = dataSource.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
        ) {
            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Error : " + e.getMessage());
        }
    }
}
