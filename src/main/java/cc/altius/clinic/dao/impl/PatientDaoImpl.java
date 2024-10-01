/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.dao.impl;

import cc.altius.clinic.dao.PatientDao;
import cc.altius.clinic.model.Patient;
import cc.altius.clinic.model.rowmapper.PatientRowMapper;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author altius
 */
@Repository
public class PatientDaoImpl implements PatientDao {

    private DataSource dataSource;
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    private JdbcTemplate jdbcTemplate;

    private String patientString = "SELECT p.PATIENT_ID, p.PATIENT_NAME, p.MOBILE, p.EMAIL_ID, p.AGE, p.GENDER FROM ms_patient p WHERE TRUE";

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    @Override
    @Transactional
    public int addPatient(Patient patient) {
        SimpleJdbcInsert si = new SimpleJdbcInsert(dataSource).withTableName("ms_patient").usingGeneratedKeyColumns("PATIENT_ID");
        Map<String, Object> params = new HashMap<>();
        params.put("PATIENT_NAME", patient.getName());
        params.put("AGE", patient.getAge());
        params.put("EMAIL_ID", patient.getEmailId());
        params.put("GENDER", patient.getGender().getId());
        params.put("MOBILE", patient.getMobile());
        System.out.println("-----> " + patient);
        return si.executeAndReturnKey(params).intValue();
    }

    @Override
    public List<Patient> findPatient(String searchString) {
        String findQuery = patientString + " AND p.PATIENT_NAME LIKE CONCAT('%',:searchString,'%')";
        Map<String, Object> params = new HashMap<>();
        params.put("searchString", searchString);
        return this.namedParameterJdbcTemplate.query(findQuery, params, new PatientRowMapper());
    }

    @Override
    public List<Patient> listPatient() {
        return this.jdbcTemplate.query(this.patientString, new PatientRowMapper());
    }

    @Override
    public Patient getPatientById(int patientId) {
        String findQuery = patientString + " AND p.PATIENT_ID=:patientId";
        Map<String, Object> params = new HashMap<>();
        params.put("patientId", patientId);
        return this.namedParameterJdbcTemplate.queryForObject(findQuery, params, new PatientRowMapper());
    }

    @Override
    @Transactional
    public int editPatient(Patient patient) {
        String updateQuery = "update ms_patient set PATIENT_NAME=:name, MOBILE=:mobile, AGE=:age, GENDER=:gender, EMAIL_ID=:emailId WHERE  PATIENT_ID=:patientId";
        Map<String, Object> params = new HashMap<>();
        params.put("name", patient.getName());
        params.put("mobile", patient.getMobile());
        params.put("age", patient.getAge());
        params.put("gender", patient.getGender().getId());
        params.put("emailId", patient.getEmailId());
        params.put("patientId", patient.getPatientId());
        return this.namedParameterJdbcTemplate.update(updateQuery, params);
    }
}
