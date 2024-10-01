/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic.service.impl;

import cc.altius.clinic.dao.MasterDao;
import cc.altius.clinic.model.IdAndLabel;
import cc.altius.clinic.service.MasterService;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author altius
 */
@Service
public class MasterServiceImpl implements MasterService {

    @Autowired
    private MasterDao masterDao;

    @Override
    public List<IdAndLabel> getSpecialityList() {
        return this.masterDao.getSpecialityList();
    }

    @Override
    public List<IdAndLabel> getRoleList() {
        return this.masterDao.getRoleList();
    }

    @Override
    public List<IdAndLabel> getGenderList() {
        return this.masterDao.getGenderList();
    }

}
