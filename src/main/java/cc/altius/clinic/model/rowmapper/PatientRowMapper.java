/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.model.rowmapper;

import cc.altius.clinic.model.IdAndLabel;
import cc.altius.clinic.model.Patient;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author altius
 */
public class PatientRowMapper implements RowMapper<Patient> {

    @Override
    public Patient mapRow(ResultSet rs, int rowNum) throws SQLException {
        Patient patient = new Patient(
                rs.getInt("PATIENT_ID"),
                rs.getString("PATIENT_NAME"),
                rs.getString("EMAIL_ID"),
                rs.getString("MOBILE"),
                new IdAndLabel(rs.getString("GENDER"), (rs.getString("GENDER").equals("M") ? "Male" : "Female")),
                rs.getInt("AGE")
        );
        return patient;
    }

}
