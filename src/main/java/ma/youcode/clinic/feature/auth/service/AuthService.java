package ma.youcode.clinic.feature.auth.service;

import ma.youcode.clinic.modal.enums.UserRole;
import org.mindrot.jbcrypt.BCrypt;

import ma.youcode.clinic.feature.auth.dao.JdbcUserDao;
import ma.youcode.clinic.feature.auth.dao.UserDao;
import ma.youcode.clinic.modal.User;

import java.util.List;

public class AuthService {
   
    private UserDao userDao;

    public AuthService(){
        userDao = new JdbcUserDao();
    }
 
    public User login(String username , String password){

        User user = userDao.findByUsername(username);

        if(user == null){
            return null;
        }

        if (!BCrypt.checkpw(password, user.getPassword())) {
            return null;
        }

        return user;
    }

}
