package ma.youcode.clinic.feature.auth.dao;

import ma.youcode.clinic.dao.Dao;
import ma.youcode.clinic.modal.User;
import ma.youcode.clinic.modal.enums.UserRole;

import java.util.List;

public interface UserDao extends Dao<User> {

    User findByUsername(String username);

    List<User> findByRole(UserRole role);
    
}