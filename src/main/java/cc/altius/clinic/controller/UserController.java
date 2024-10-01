/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.controller;

import cc.altius.clinic.model.IdAndLabel;
import cc.altius.clinic.model.User;
import cc.altius.clinic.model.propertyEditor.IdAndLabelPropertyEditor;
import cc.altius.clinic.service.MasterService;
import cc.altius.clinic.service.UserService;
import java.util.AbstractMap;
import java.util.Arrays;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author altius
 */
@Controller
public class UserController {

    @Autowired
    private MasterService masterService;
    @Autowired
    private UserService userService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(IdAndLabel.class, new IdAndLabelPropertyEditor());
    }

    @RequestMapping(value = "listUser.htm", method = RequestMethod.GET)
    public String listUser(ModelMap model) {
        model.addAttribute("userList", userService.getUserList());
        return "listUser";
    }

    @RequestMapping(value = "addUser.htm", method = RequestMethod.GET)
    public String showAddUser(ModelMap model) {
        model.addAttribute("roleList", masterService.getRoleList());
        model.addAttribute("specialityList", masterService.getSpecialityList());
        model.addAttribute("user", new User());
        return "addUser";
    }

    @RequestMapping(value = "addUser.htm", method = RequestMethod.POST)
    public String addUser(@ModelAttribute User user, ModelMap model) {
        int userId = this.userService.addUser(user);
        return "redirect:listUser.htm?msg=User Id " + userId + " added successfully.";
    }

    @RequestMapping(value = "showEditUser.htm", method = RequestMethod.POST)
    public String showEditUser(@RequestParam int userId, ModelMap model) {
        model.addAttribute("user", userService.getUserByUserId(userId));
        model.addAttribute("roleList", masterService.getRoleList());
        model.addAttribute("activeList", Arrays.asList(new AbstractMap.SimpleEntry<>("Active", true), new AbstractMap.SimpleEntry<>("Deactive", false)));
        model.addAttribute("specialityList", masterService.getSpecialityList());
//        model.addAttribute("activeList", masterService.getUserStatusMap());
        return "editUser";
    }

    @RequestMapping(value = "editUser.htm", method = RequestMethod.POST)
    public String editUser(@ModelAttribute User user, ModelMap model) {
        try {
            int rows = this.userService.editUser(user);
            System.out.println(user);
            if (rows == 0) {
                return "redirect:listUser.htm?msg=Nothing to update";
            } else {
                return "redirect:listUser.htm?msg=User successfully updated";
            }
        } catch (Exception e) {
            model.addAttribute("user", user);
            model.addAttribute("roleList", this.masterService.getRoleList());
            model.addAttribute("specialityList", this.masterService.getSpecialityList());
            model.addAttribute("activeList", Arrays.asList(new AbstractMap.SimpleEntry<>("Active", true), new AbstractMap.SimpleEntry<>("Deactive", false)));
            model.addAttribute("msg", "User could not be updated - " + e.getMessage());
            return "editUser";
        }
    }

}
