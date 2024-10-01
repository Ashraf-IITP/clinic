/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package cc.altius.clinic.dao;

import cc.altius.clinic.model.DoctorCalendar;
import cc.altius.clinic.model.DoctorIdAndScheduleDate;
import cc.altius.clinic.model.DoctorSchedule;
import cc.altius.clinic.model.IdAndLabel;
import cc.altius.clinic.model.ScheduleTime;
import java.util.Date;
import java.util.List;

/**
 *
 * @author altius
 */
public interface DoctorDao {

    public List<IdAndLabel> getDoctorList();

    public DoctorSchedule getDoctorSchedule(int doctorId, String scheduleDate);

    public int addDoctorSchedule(DoctorSchedule doctorSchedule);

    public List<ScheduleTime> getDoctorScheduleList(DoctorIdAndScheduleDate inputParams);

    public List<String> getDrAvailableSots(DoctorIdAndScheduleDate doctorSchedule);

    public List<DoctorCalendar> getDoctorCalendar(DoctorIdAndScheduleDate doctorSchedule);
}
