/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.dao.impl;

import cc.altius.clinic.dao.UserDao;
import cc.altius.clinic.model.IdAndLabel;
import cc.altius.clinic.model.User;
import cc.altius.clinic.model.rowmapper.UserRowMapper;
import cc.altius.clinic.service.MasterService;
import cc.altius.utils.PassPhrase;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author altius
 */
@Repository
public class UserDaoImpl implements UserDao {

    private DataSource dataSource;
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    private JdbcTemplate jdbcTemplate;

    private MasterService masterService;
    private List<IdAndLabel> specialityList;

    @Autowired
    public void setMasterDao(MasterService masterService) {
        this.masterService = masterService;
        this.specialityList = this.masterService.getSpecialityList();
    }

    private final String userSql = "select u1.* from (select u.USER_ID,u.NAME,u.USERNAME,u.PASSWORD,u.ACTIVE,r.ROLE_ID,r.ROLE_DESC,d.SPECIALITY_IDS, GROUP_CONCAT(rbf.BUSINESS_FUNCTION_ID)'BUSINESS_FUNCTION_IDS' from us_user u "
            + "left join us_role r on u.ROLE_ID=r.ROLE_ID "
            + "left join us_role_business_function rbf on r.ROLE_ID=rbf.ROLE_ID "
            + "left join ms_doctor d on u.USER_ID=d.USER_ID "
            + "group by u.USER_ID, d.SPECIALITY_IDS) as u1 where true ";

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    @Override
    public List<User> getUserList() {
        return this.jdbcTemplate.query(userSql, new UserRowMapper(this.specialityList));
    }

    @Override
    @Transactional
    public int addUser(User user) {
        SimpleJdbcInsert se = new SimpleJdbcInsert(dataSource).withTableName("us_user").usingGeneratedKeyColumns("USER_ID");
        Map<String, Object> params = new HashMap<>();
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        params.put("NAME", user.getName());
        params.put("USERNAME", user.getUsername());
        String password = PassPhrase.getPassword(8);
//        String password = "password";
        System.out.println("password---> " + password);
        params.put("PASSWORD", encoder.encode(password));
        params.put("ROLE_ID", user.getRole().getId());
        params.put("ACTIVE", true);

        int userId = se.executeAndReturnKey(params).intValue();

        if (user.getRole().getId().equals("ROLE_DOCTOR")) {
            SimpleJdbcInsert sd = new SimpleJdbcInsert(dataSource).withTableName("ms_doctor");
            params.clear();
            params.put("USER_ID", userId);
            params.put("SPECIALITY_IDS", user.getSpecialityList().stream().map(IdAndLabel::getId).collect(Collectors.joining(",")));
            sd.execute(params);
        }

        return userId;
    }

    @Override
    public User getUserByUserId(int userId) {
        String sqlQuery = userSql + "and u1.USER_ID=:userId";
        Map<String, Object> param = new HashMap<>();
        param.put("userId", userId);
        return this.namedParameterJdbcTemplate.queryForObject(sqlQuery, param, new UserRowMapper(this.specialityList));
    }

    @Override
    @Transactional
    public int editUser(User user) {
        String sqlQuery = "update us_user set NAME=:name,USERNAME=:username,ACTIVE=:active WHERE USER_ID=:userId";
        Map<String, Object> params = new HashMap<>();
        params.put("name", user.getName());
        params.put("username", user.getUsername());
        params.put("active", user.isActive());
        params.put("userId", user.getUserId());

        int rowsUpdated = this.namedParameterJdbcTemplate.update(sqlQuery, params);

        if (user.getRole().getId().equals("ROLE_DOCTOR")) {
            sqlQuery = "update ms_doctor set SPECIALITY_IDS=:specialityIds where USER_ID=:userId";
            params.clear();
            params.put("specialityIds", user.getSpecialityListIds());
            params.put("userId", user.getUserId());
            this.namedParameterJdbcTemplate.update(sqlQuery, params);
        }

        return rowsUpdated;
    }

    @Override
    public User loadUserByUsername(String username) {
        String sqlQuery = userSql + "and u1.USERNAME=:username";
        Map<String, Object> param = new HashMap<>();
        param.put("username", username);
        return this.namedParameterJdbcTemplate.queryForObject(sqlQuery, param, new UserRowMapper(this.specialityList));
    }

}
