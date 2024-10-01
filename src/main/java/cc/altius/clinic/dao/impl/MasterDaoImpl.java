/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.dao.impl;

import cc.altius.clinic.dao.MasterDao;
import cc.altius.clinic.model.IdAndLabel;
import cc.altius.clinic.model.rowmapper.IdAndLabelRowMapper;
import java.util.Arrays;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

/**
 *
 * @author altius
 */
@Repository
public class MasterDaoImpl implements MasterDao {

    private DataSource dataSource;
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    @Override
    public List<IdAndLabel> getSpecialityList() {
        return this.jdbcTemplate.query("select s.SPECIALITY_ID AS ID, s.SPECIALITY_DESC AS LABEL FROM ms_speciality s", new IdAndLabelRowMapper());
    }

    @Override
    public List<IdAndLabel> getRoleList() {
        return this.jdbcTemplate.query("select r.ROLE_ID AS ID, r.ROLE_DESC AS LABEL FROM us_role r", new IdAndLabelRowMapper());
    }

    @Override
    public List<IdAndLabel> getGenderList() {
        return Arrays.asList(new IdAndLabel("M", "Male"), new IdAndLabel("F", "Female"));
    }

}
