/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.model;

import java.io.Serializable;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 *
 * @author altius
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class Appointment implements Serializable {

    @EqualsAndHashCode.Include
    private int appointmentId;
    private IdAndLabel patient;
    private IdAndLabel doctor;
    private String scheduleDate;
    private String startTime;
    private IdAndLabel appointmentStatus;
    private IdAndLabel createdBy;
    private Date createdDate;
    private IdAndLabel lastModifiedBy;
    private Date lastModifiedDate;

}
