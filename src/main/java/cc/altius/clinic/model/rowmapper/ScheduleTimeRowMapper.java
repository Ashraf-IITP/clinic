/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.model.rowmapper;

import cc.altius.clinic.model.ScheduleTime;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author altius
 */
public class ScheduleTimeRowMapper implements RowMapper<ScheduleTime> {

    @Override
    public ScheduleTime mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new ScheduleTime(
                rs.getString("START_TIME") != null ? rs.getString("START_TIME").substring(0, 5) : null,
                rs.getString("STOP_TIME") != null ? rs.getString("STOP_TIME").substring(0, 5) : null
        );
    }

}
