/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.controller;

import cc.altius.clinic.model.IdAndLabel;
import cc.altius.clinic.model.Patient;
import cc.altius.clinic.model.propertyEditor.IdAndLabelPropertyEditor;
import cc.altius.clinic.service.MasterService;
import cc.altius.clinic.service.PatientService;
import java.util.List;
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
public class PatientController {

    @Autowired
    private MasterService masterService;
    @Autowired
    private PatientService patientSerivce;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(IdAndLabel.class, new IdAndLabelPropertyEditor());
    }

    @RequestMapping(value = "addPatient.htm", method = RequestMethod.GET)
    public String showAddPatient(ModelMap model) {
        model.addAttribute("genderList", this.masterService.getGenderList());
        model.addAttribute("patient", new Patient());
        return "addPatient";
    }

    @RequestMapping(value = "addPatient.htm", method = RequestMethod.POST)
    public String addPatient(@ModelAttribute Patient patient, ModelMap model) {
        try {
            int patientId = this.patientSerivce.addPatient(patient);
            return "redirect:searchPatient.htm?msg=Patient added successfully";
        } catch (Exception e) {
            model.addAttribute("patient", patient);
            model.addAttribute("genderList", this.masterService.getGenderList());
            model.addAttribute("msg", "Failed to add Patient - " + e.getMessage());
            return "addPatient";
        }
    }

    @RequestMapping(value = "searchPatient.htm", method = RequestMethod.GET)
    public String searchPatient(@RequestParam(value = "searchString", required = false, defaultValue = "") String searchString, ModelMap model) {
        if (!searchString.isBlank()) {
            model.addAttribute("searchString", searchString);
            List<Patient> searchedPatients = patientSerivce.findPatient(searchString);
            model.addAttribute("patientList", searchedPatients);
        }
        return "searchPatient";
    }

    @RequestMapping(value = "showEditPatient.htm", method = RequestMethod.POST)
    public String showEditPatientPage(@RequestParam(value = "patientId", required = true) int patientId, ModelMap model) {
        model.addAttribute("genderList", this.masterService.getGenderList());
        model.addAttribute("patient", this.patientSerivce.getPatientById(patientId));
        return "editPatient";
    }

    @RequestMapping(value = "editPatient.htm", method = RequestMethod.POST)
    public String editPatient(@ModelAttribute Patient patient, ModelMap model) {
        try {
            int rowsUpdated = this.patientSerivce.editPatient(patient);
            if (rowsUpdated == 0) {
                return "redirect:searchPatient.htm?msg=Nothing to update.";
            } else {
                return "redirect:searchPatient.htm?msg=Patient data with id= " + patient.getPatientId() + " got updated successfully.";
            }
        } catch (Exception e) {
            model.addAttribute("genderList", masterService.getGenderList());
            model.addAttribute("patient", new Patient());
            model.addAttribute("msg", "Failed to update Patient with id= " + patient.getPatientId() + " " + e.getMessage());
            return "redirect:listPatient.htm";
        }
    }
    
    
    @RequestMapping(value = "listPatient.htm", method = RequestMethod.GET)
    public String listPatient(ModelMap model) {
        model.addAttribute("patientList", this.patientSerivce.listPatient());
        return "listPatient";
    }

}
