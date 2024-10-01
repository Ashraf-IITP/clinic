/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package cc.altius.clinic.service;

import cc.altius.clinic.model.User;
import java.util.List;

/**
 *
 * @author altius
 */
public interface UserService {

    public List<User> getUserList();

    public int addUser(User user);

    public User getUserByUserId(int userId);

    public int editUser(User user);
}
