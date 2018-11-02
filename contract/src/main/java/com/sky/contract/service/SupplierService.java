package com.sky.contract.service;

import com.sky.contract.mapper.SupplierMapper;
import com.sky.contract.model.Supplier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by daNuo.
 */

@Service
public class SupplierService {

    @Autowired
    private SupplierMapper supplierMapper;

    public List<Supplier>  getAllByType(Short type){
        Supplier supplier=new Supplier();
        supplier.setType(type);
        return supplierMapper.select(supplier);
    }


}
