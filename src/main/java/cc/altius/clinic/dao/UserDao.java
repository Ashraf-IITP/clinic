/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package cc.altius.clinic.dao;

import cc.altius.clinic.model.User;
import java.util.List;
import org.springframework.security.core.userdetails.UserDetails;

/**
 *
 * @author altius
 */
public interface UserDao {

    public List<User> getUserList();

    public int addUser(User user);

    public User getUserByUserId(int userId);

    public int editUser(User user);
    
    public User loadUserByUsername(String username);
}
