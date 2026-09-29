package ma.youcode.clinic.feature.auth.dao;

import ma.youcode.clinic.dao.Dao;
import ma.youcode.clinic.modal.User;

public interface UserDao extends Dao<User> {

    User findByUsername(String username);
    
}