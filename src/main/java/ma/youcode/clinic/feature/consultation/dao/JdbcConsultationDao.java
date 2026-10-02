package ma.youcode.clinic.feature.consultation.dao;

import ma.youcode.clinic.config.DatasourceConfig;
import ma.youcode.clinic.feature.auth.dao.JdbcUserDao;
import ma.youcode.clinic.feature.auth.dao.UserDao;
import ma.youcode.clinic.feature.patient.dao.JdbcPatientDAO;
import ma.youcode.clinic.feature.patient.dao.PatientDAO;
import ma.youcode.clinic.modal.Consultation;
import ma.youcode.clinic.modal.Patient;
import ma.youcode.clinic.modal.User;
import ma.youcode.clinic.modal.enums.StatutConsultation;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JdbcConsultationDao implements ConsultationDao {

    private PatientDAO patientDAO;
    private UserDao userDao;

    public JdbcConsultationDao() {
        patientDAO = new JdbcPatientDAO();
        userDao = new JdbcUserDao();
    }

    @Override
    public void save(Consultation consultation) {
        String sql = "INSERT INTO consultations (patient_id , doctor_id , motif , observations , diagnostic , treatment , cout , statut) VALUES (? , ? , ? , ? , ? , ? , ? , ?)";

        try (
                Connection connection = DatasourceConfig.getDataSource().getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            System.out.println("========== Add Consultation in DB ==========");

            statement.setLong(1, consultation.getPatient().getId());

            if (consultation.getDoctor() == null) {
                statement.setNull(2, Types.BIGINT);
            } else {
                statement.setLong(2 , consultation.getDoctor().getId());
            }

            statement.setString(3, consultation.getMotif());
            statement.setString(4, consultation.getObservations());
            statement.setString(5, consultation.getDiagnostic());
            statement.setString(6, consultation.getTreatment());

            if (consultation.getCout() == null) {
                statement.setNull(7 , Types.DOUBLE);
            } else {
                statement.setDouble(7, consultation.getCout());
            }

            statement.setString(8, consultation.getStatut().name());

            statement.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Error : " + e.getMessage());
        }

    }

    @Override
    public Consultation findById(long id) {
        return null;
    }

    @Override
    public void delete(long id) {
        String sql = "DELETE FROM consultations WHERE id = ?";

        try (
                Connection connection = DatasourceConfig.getDataSource().getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);) {

            statement.setLong(1, id);

            statement.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Error : " + e.getMessage());
        }
    }

    @Override
    public List<Consultation> findAll() {
        List<Consultation> consultations = new ArrayList<>();

        String sql = "SELECT * FROM consultations";

        try (
                Connection connection = DatasourceConfig.getDataSource().getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);) {

            try (ResultSet result = statement.executeQuery()) {
                while (result.next()) {
                    Patient patient = patientDAO.findById(result.getLong("patient_id"));
                    User doctor = userDao.findById(result.getLong("doctor_id"));

                    consultations.add(new Consultation(
                            result.getLong("id"),
                            patient,
                            doctor,
                            result.getString("motif"),
                            result.getString("observations"),
                            result.getString("diagnostic"),
                            result.getString("treatment"),
                            result.getDouble("cout"),
                            StatutConsultation.valueOf(result.getString("statut")),
                            result.getTimestamp("date_consultation").toLocalDateTime()));
                }
            }

            return consultations;

        } catch (SQLException e) {
            System.err.println("Error : " + e.getMessage());
        }
        return List.of();
    }

    @Override
    public List<Consultation> findByStatut() {

        List<Consultation> consultations = new ArrayList<>();
        String sql = "SELECT * FROM consultations WHERE statut = ?";

        try (
                Connection connection = DatasourceConfig.getDataSource().getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql);
        ) {

            stmt.setString(1, StatutConsultation.EN_COURS.name());

            try (ResultSet result = stmt.executeQuery()) {
                while (result.next()) {

                    Patient patient = patientDAO.findById(result.getLong("patient_id"));
                    User doctor = userDao.findById(result.getLong("doctor_id"));

                    Consultation consultation = new Consultation(
                            result.getLong("id"),
                            patient,
                            doctor,
                            result.getString("motif"),
                            result.getString("observations"),
                            result.getString("diagnostic"),
                            result.getString("treatment"),
                            result.getDouble("cout"),
                            StatutConsultation.valueOf(result.getString("statut")),
                            result.getTimestamp("date_consultation").toLocalDateTime()
                    );

                    consultations.add(consultation);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error : " + e.getMessage());
        }

        return consultations;
    }
}
