/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.service.impl;

import cc.altius.clinic.dao.DoctorDao;
import cc.altius.clinic.model.DoctorCalendar;
import cc.altius.clinic.model.DoctorIdAndScheduleDate;
import cc.altius.clinic.model.DoctorSchedule;
import cc.altius.clinic.model.IdAndLabel;
import cc.altius.clinic.model.ScheduleTime;
import cc.altius.clinic.service.DoctorService;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author altius
 */
@Service
public class DoctorServiceImpl implements DoctorService {

    @Autowired
    private DoctorDao doctorDao;

    @Override
    public List<IdAndLabel> getDoctorList() {
        return doctorDao.getDoctorList();
    }

    @Override
    public DoctorSchedule getDoctorSchedule(int doctorId, String scheduleDate) {
        return doctorDao.getDoctorSchedule(doctorId, scheduleDate);
    }

    @Override
    public int addDoctorSchedule(DoctorSchedule doctorSchedule) {
        return this.doctorDao.addDoctorSchedule(doctorSchedule);
    }

    @Override
    public List<ScheduleTime> getDoctorScheduleList(DoctorIdAndScheduleDate inputParams) {
        return this.doctorDao.getDoctorScheduleList(inputParams);
    }

    @Override
    public List<String> getDrAvailableSots(DoctorIdAndScheduleDate doctorSchedule) {
        return this.doctorDao.getDrAvailableSots(doctorSchedule);
    }

    @Override
    public List<DoctorCalendar> getDoctorCalendar(DoctorIdAndScheduleDate doctorSchedule) {
        return this.doctorDao.getDoctorCalendar(doctorSchedule);
    }
}
