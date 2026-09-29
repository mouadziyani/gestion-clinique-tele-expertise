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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
        String sql = "DELETE FROM consultation WHERE id = ?";

        try (
                Connection connection = DatasourceConfig.getDataSource().getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
        ) {

            statement.setLong(1, id);

            statement.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Error : " + e.getMessage());
        }
    }

    @Override
    public List<Consultation> findAll() {
        List<Consultation> consultations = new ArrayList<>();

        String sql = "SELECT id, patient_id, doctor_id, motif, observations, diagnostic, treatment, cout, statut, date_consultation FROM consultation";

        try (
                Connection connection = DatasourceConfig.getDataSource().getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
        ) {

            try (ResultSet result = statement.executeQuery()) {
                while (result.next()) {
                    Patient patient = patientDAO.findById(result.getInt("patient_id"));
                    User doctor = userDao.findById(result.getInt("doctor_id"));

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
                            result.getTimestamp("date_consultation").toLocalDateTime()
                    ));
                }
            }

            return consultations;

        } catch (SQLException e) {
            System.err.println("Error : " + e.getMessage());
        }
        return List.of();
    }
}
