package ma.youcode.clinic.modal;

import ma.youcode.clinic.modal.enums.UserRole;

public class User {
    private Long id;
    private String username;
    private String password;
    private UserRole Role;

    public User(long id, String username, String password, UserRole role) {
        this.id = id;
        this.username = username;
        this.password = password;
        Role = role;
    }

    public Long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserRole getRole() {
        return Role;
    }

    public void setRole(UserRole role) {
        Role = role;
    }
}
