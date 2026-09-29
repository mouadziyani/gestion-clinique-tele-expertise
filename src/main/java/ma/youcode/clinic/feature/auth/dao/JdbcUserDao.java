package ma.youcode.clinic.feature.auth.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ma.youcode.clinic.config.DatasourceConfig;
import ma.youcode.clinic.modal.User;
import ma.youcode.clinic.modal.enums.UserRole;

public class JdbcUserDao implements UserDao {

    @Override
    public void save(User user) {
       
    }
        @Override
        public void delete(int id) {
            
        }

    @Override
    public User findById(int id) {

        String sql = "SELECT * FROM users WHERE id = ? ";

        try (Connection con = DatasourceConfig.getDataSource().getConnection();
            PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setInt(1, id);
            ResultSet result = pstmt.executeQuery();

            if(result.next()){
                return new User(result.getLong("id"), result.getString("username"),
                 result.getString("password"), UserRole.valueOf(result.getString("role")));
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    @Override
    public java.util.List<User> findAll() {
        return null;
    }

    @Override
    public User findByUsername(String username) {
        return null;
    }
}