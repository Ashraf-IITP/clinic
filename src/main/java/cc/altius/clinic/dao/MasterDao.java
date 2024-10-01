/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package cc.altius.clinic.dao;

import cc.altius.clinic.model.IdAndLabel;
import java.util.List;

/**
 *
 * @author altius
 */
public interface MasterDao {

    public List<IdAndLabel> getSpecialityList();

    public List<IdAndLabel> getRoleList();

    public List<IdAndLabel> getGenderList();

}
