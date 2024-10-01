/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.service.impl;

import cc.altius.clinic.dao.PatientDao;
import cc.altius.clinic.model.Patient;
import cc.altius.clinic.service.PatientService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author altius
 */
@Service
public class PatientServiceImpl implements PatientService{

    @Autowired
    private PatientDao patientDao;
    
    @Override
    public int addPatient(Patient patient) {
        return patientDao.addPatient(patient);
    }

    @Override
    public List<Patient> findPatient(String searchString) {
        return patientDao.findPatient(searchString);
    }

    @Override
    public List<Patient> listPatient() {
        return patientDao.listPatient();
    }

    @Override
    public Patient getPatientById(int patientId) {
        return patientDao.getPatientById(patientId);
    }

    @Override
    public int editPatient(Patient patient) {
        return patientDao.editPatient(patient);
    }
    
}
