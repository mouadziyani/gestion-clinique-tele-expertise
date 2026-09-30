package ma.youcode.clinic.feature.auth.service;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;

import ma.youcode.clinic.feature.auth.dao.JdbcUserDao;
import ma.youcode.clinic.feature.auth.dao.UserDao;
import ma.youcode.clinic.modal.User;

public class AuthService {
   
    private UserDao userDao;

    public AuthService(){
        userDao = new JdbcUserDao();
    }
 
    public User login(String username , String password){

        User user = userDao.findByUsername(username);

        if(user == null){
            System.out.println("user not trouvable");
            return null;
        }

        if (!BCrypt.checkpw(password, user.getPassword())) {
            System.out.println("password incorrect");
            return null;
        }

        return user;
    }

}
