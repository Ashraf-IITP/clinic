/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package cc.altius.clinic.service;

import cc.altius.clinic.model.Appointment;

/**
 *
 * @author altius
 */
public interface AppointmentService {

    public int addAppointment(Appointment apt);

    public Appointment getAppointmentById(int appointmentId);

    public int editAppointment(Appointment apt);
}
