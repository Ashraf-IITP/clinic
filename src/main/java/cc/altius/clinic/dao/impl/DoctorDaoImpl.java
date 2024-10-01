/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.dao.impl;

import cc.altius.clinic.dao.DoctorDao;
import cc.altius.clinic.model.DoctorCalendar;
import cc.altius.clinic.model.DoctorIdAndScheduleDate;
import cc.altius.clinic.model.DoctorSchedule;
import cc.altius.clinic.model.IdAndLabel;
import cc.altius.clinic.model.ScheduleTime;
import cc.altius.clinic.model.rowmapper.DoctorCalendarRowMapper;
import cc.altius.clinic.model.rowmapper.DoctorScheduleRowMapper;
import cc.altius.clinic.model.rowmapper.IdAndLabelRowMapper;
import cc.altius.clinic.model.rowmapper.ScheduleTimeRowMapper;
import java.util.Date;
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
public class DoctorDaoImpl implements DoctorDao {

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
    public List<IdAndLabel> getDoctorList() {
        String sqlQuery = "select d.DOCTOR_ID AS id, u.NAME AS label FROM ms_doctor d left join us_user u on d.USER_ID=u.USER_ID";
        return this.jdbcTemplate.query(sqlQuery, new IdAndLabelRowMapper());
    }

    @Override
    @Transactional
    public DoctorSchedule getDoctorSchedule(int doctorId, String scheduleDate) {
        String sqlQuery = "select d.DOCTOR_ID, u.NAME AS DOCTOR_NAME, ds.SCHEDULE_DATE FROM ms_doctor d left join us_user u on d.USER_ID=u.USER_ID left join ms_doctor_schedule ds on d.DOCTOR_ID=ds.DOCTOR_ID where d.DOCTOR_ID=:doctorId AND ds.SCHEDULE_DATE=:scheduleDate";
        Map<String, Object> params = new HashMap<>();
        params.put("doctorId", doctorId);
        params.put("scheduleDate", scheduleDate);
        DoctorSchedule ds = this.namedParameterJdbcTemplate.queryForObject(sqlQuery, params, new DoctorScheduleRowMapper());
        sqlQuery = "select ds.START_TIME, ds.STOP_TIME FROM ms_doctor_schedule ds where ds.DOCTOR_ID=:doctorId and SCHEDULE_DATE=:scheduleDate";
        ds.setScheduleTimeList(this.namedParameterJdbcTemplate.query(sqlQuery, params, new ScheduleTimeRowMapper()));
        return ds;
    }

    @Override
    public int addDoctorSchedule(DoctorSchedule doctorSchedule) {
        String sqlQuery = "delete from ms_doctor_schedule where DOCTOR_ID=:DOCTOR_ID and SCHEDULE_DATE=:SCHEDULE_DATE";
        Map<String, Object> params = new HashMap<>();
        params.put("DOCTOR_ID", doctorSchedule.getDoctor().getId());
        params.put("SCHEDULE_DATE", doctorSchedule.getScheduleDate());
        this.namedParameterJdbcTemplate.update(sqlQuery, params);
        int rows = 0;
        SimpleJdbcInsert si = new SimpleJdbcInsert(dataSource).withTableName("ms_doctor_schedule");
        params.put("START_TIME", null);
        params.put("STOP_TIME", null);
        for (ScheduleTime st : doctorSchedule.getScheduleTimeList()) {
            params.replace("START_TIME", st.getStartTime());
            params.replace("STOP_TIME", st.getStopTime());
            si.execute(params);
            rows++;
        }
        return rows;
    }

    @Override
    public List<ScheduleTime> getDoctorScheduleList(DoctorIdAndScheduleDate inputParams) {
        String sqlString = "SELECT ds.START_TIME, ds.STOP_TIME FROM ms_doctor_schedule ds WHERE ds.DOCTOR_ID=:doctorId AND ds.SCHEDULE_DATE=:scheduleDate";
        Map<String, Object> params = new HashMap<>();
        System.out.println("cc.altius.clinic.dao.impl.DoctorDaoImpl.getDoctorScheduleList() "+inputParams.getScheduleDate());
        params.put("doctorId", inputParams.getDoctorId());
        params.put("scheduleDate", inputParams.getScheduleDate());
        return this.namedParameterJdbcTemplate.query(sqlString, params, new ScheduleTimeRowMapper());

    }

    @Override
    public List<DoctorCalendar> getDoctorCalendar(DoctorIdAndScheduleDate doctorSchedule) {
        String sqlString = "SELECT LEFT(ts.TIME_SLOT,5) `TIME_SLOT`, a.APPOINTMENT_ID, p.PATIENT_ID, p.PATIENT_NAME "
                + "FROM ms_doctor_schedule ds  "
                + "LEFT JOIN ms_time_slots ts ON ts.TIME_SLOT >=ds.START_TIME AND ts.TIME_SLOT < ds.STOP_TIME  "
                + "LEFT JOIN ms_appointment a ON ds.DOCTOR_ID=a.DOCTOR_ID AND ds.SCHEDULE_DATE=a.SCHEDULE_DATE AND a.START_TIME=ts.TIME_SLOT "
                + "LEFT JOIN ms_patient p ON a.PATIENT_ID=p.PATIENT_ID "
                + "WHERE ds.DOCTOR_ID=:doctorId AND ds.SCHEDULE_DATE=:scheduleDate "
                + "ORDER BY ts.TIME_SLOT";
        Map<String, Object> params = new HashMap<>();
        System.out.println(doctorSchedule);
        System.out.println("------------------------");
        params.put("doctorId", doctorSchedule.getDoctorId());
        params.put("scheduleDate", doctorSchedule.getScheduleDate());
        return this.namedParameterJdbcTemplate.query(sqlString, params, new DoctorCalendarRowMapper());
    }

    @Override
    public List<String> getDrAvailableSots(DoctorIdAndScheduleDate doctorSchedule) {
        String sqlString = "SELECT LEFT(ts.TIME_SLOT,5) `AVAILABLE_TIME_SLOT` "
                + "FROM ms_doctor_schedule ds  "
                + "LEFT JOIN ms_time_slots ts ON ts.TIME_SLOT >=ds.START_TIME AND ts.TIME_SLOT < ds.STOP_TIME  "
                + "LEFT JOIN ms_appointment a ON ds.DOCTOR_ID=a.DOCTOR_ID AND ds.SCHEDULE_DATE=a.SCHEDULE_DATE AND a.START_TIME=ts.TIME_SLOT "
                + "WHERE ds.DOCTOR_ID=:doctorId AND ds.SCHEDULE_DATE=:scheduleDate AND a.APPOINTMENT_ID IS NULL "
                + "ORDER BY ts.TIME_SLOT";
        Map<String, Object> params = new HashMap<>();
        params.put("doctorId", doctorSchedule.getDoctorId());
        params.put("scheduleDate", doctorSchedule.getScheduleDate());
        return this.namedParameterJdbcTemplate.queryForList(sqlString, params, String.class);
    }
}
