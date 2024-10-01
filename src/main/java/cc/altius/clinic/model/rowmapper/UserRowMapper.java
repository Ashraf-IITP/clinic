/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.model.rowmapper;

import cc.altius.clinic.model.IdAndLabel;
import cc.altius.clinic.model.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

/**
 *
 * @author altius
 */
public class UserRowMapper implements RowMapper<User> {

    private Map<String, IdAndLabel> specialityMap;

    public UserRowMapper(List<IdAndLabel> specialityList) {
        if (specialityList != null) {
            this.specialityMap = specialityList.stream().collect(Collectors.toMap(IdAndLabel::getId, s -> s));
        }
    }

    @Override
    public User mapRow(ResultSet rs, int rowNum) throws SQLException {
        User u = new User(rs.getInt("USER_ID"), rs.getString("NAME"), rs.getString("USERNAME"), rs.getString("PASSWORD"), new IdAndLabel(rs.getString("ROLE_ID"), rs.getString("ROLE_DESC")), null, null, rs.getBoolean("ACTIVE"));

        List<IdAndLabel> specialityList = new LinkedList<>();
        if (rs.getString("SPECIALITY_IDS") != null) {
            Arrays.stream(rs.getString("SPECIALITY_IDS").split(",")).forEach(i -> {
                specialityList.add(specialityMap.get(i));
            });
        }
        u.setSpecialityList(specialityList);

        List<GrantedAuthority> bussinessFunctionList = new LinkedList<>();
        Arrays.stream(rs.getString("BUSINESS_FUNCTION_IDS").split(",")).forEach(i -> {
            bussinessFunctionList.add(new SimpleGrantedAuthority(i));
        });
        u.setBusinessFunctionList(bussinessFunctionList);
        return u;
    }

}
