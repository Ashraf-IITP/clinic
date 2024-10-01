/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author altius
 */
@Controller
public class LoginController {
    
    @RequestMapping("/")
    public String showRoot(){
        return "redirect:index.htm";
    }
    
    @RequestMapping("/login.htm")
    public String showLoginPage(){
        return "login";
    }
    
    @RequestMapping("/index.htm")
    public String showIndexPage(){
        return "index";
    }
}
