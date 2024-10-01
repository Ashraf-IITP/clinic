/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.model;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @author altius
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DoctorCalendar implements Serializable {

    private String timeSlot;
    private Integer appointmentId;
    private IdAndLabel patient;

}
