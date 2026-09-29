package ma.youcode.clinic.feature.auth.dao;

import java.sql.*;
import java.util.*;

import ma.youcode.clinic.config.DatasourceConfig;
import ma.youcode.clinic.modal.User;
import ma.youcode.clinic.modal.enums.UserRole;

public class JdbcUserDao implements UserDao {

    @Override
    public void save(User user) {

        String sql = "INSERT INTO users(username, password, role) VALUES (?, ?, ?)";

        try (Connection con = DatasourceConfig.getDataSource().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getRole().name());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }

    @Override
    public void delete(int id) {

        String sql = "DELETE FROM users WHERE id = ?";

        try (Connection con = DatasourceConfig.getDataSource().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, id);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }

    @Override
    public User findById(int id) {

        String sql = "SELECT * FROM users WHERE id = ? ";

        try (Connection con = DatasourceConfig.getDataSource().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet result = pstmt.executeQuery();

            if (result.next()) {
                return new User(result.getLong("id"), result.getString("username"),
                        result.getString("password"), UserRole.valueOf(result.getString("role")));
            }

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }

        return null;
    }

    @Override
    public List<User> findAll() {

        String sql = "SELECT * FROM users";
        List<User> users = new ArrayList<>();

        try (Connection con = DatasourceConfig.getDataSource().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet result = pstmt.executeQuery()) {

            while (result.next()) {
                users.add(new User(result.getLong("id"), result.getString("username"),
                        result.getString("password"), UserRole.valueOf(result.getString("role"))));
            }

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }

        return users;
    }

    @Override
    public User findByUsername(String username) {

        String sql = "SELECT * FROM users WHERE username = ?";

        try (Connection con = DatasourceConfig.getDataSource().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, username);
            ResultSet result = pstmt.executeQuery();

            if (result.next()) {
                return new User(result.getLong("id"), result.getString("username"),
                        result.getString("password"), UserRole.valueOf(result.getString("role")));
            }

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }

        return null;
    }
}