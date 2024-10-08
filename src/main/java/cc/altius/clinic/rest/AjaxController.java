/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.rest;

import cc.altius.clinic.model.DoctorIdAndScheduleDate;
import cc.altius.clinic.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author altius
 */
@RestController
public class AjaxController {

    @Autowired
    private DoctorService doctorService;

    @PostMapping("/ajaxGetDoctorSchedules.htm")
    public ResponseEntity getScheduleTime(@RequestParam(value = "doctorId", required = true) int doctorId, @RequestParam(value = "scheduleDate", required = true) String scheduleDate) {
        try {
            return new ResponseEntity(this.doctorService.getDoctorScheduleList(new DoctorIdAndScheduleDate(doctorId, scheduleDate)), HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/ajaxGetDrAvailableSlots.htm")
    public ResponseEntity getDrAvailableSlots(@RequestParam(value = "doctorId", required = true) int doctorId, @RequestParam(value = "scheduleDate", required = true) String scheduleDate) {
        try {
            return new ResponseEntity(this.doctorService.getDrAvailableSots(new DoctorIdAndScheduleDate(doctorId, scheduleDate)), HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/ajaxGetDoctorCalendar.htm")
    public ResponseEntity getDoctorCalendar(@RequestParam(value = "doctorId", required = true) int doctorId, @RequestParam(value = "scheduleDate", required = true) String scheduleDate) {
        try {
            return new ResponseEntity(this.doctorService.getDoctorCalendar(new DoctorIdAndScheduleDate(doctorId, scheduleDate)), HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
