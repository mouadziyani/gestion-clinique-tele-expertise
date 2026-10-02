package ma.youcode.clinic.feature.auth.service;

import ma.youcode.clinic.feature.auth.dao.JdbcUserDao;
import ma.youcode.clinic.feature.auth.dao.UserDao;
import ma.youcode.clinic.modal.User;
import ma.youcode.clinic.modal.enums.UserRole;

import java.util.List;

public class UserService {
    private UserDao userDao;

    public UserService(){
        userDao = new JdbcUserDao();
    }

    public List<User> getAllDoctors() {
        return userDao.findByRole(UserRole.GENERALIST);
    }
}
