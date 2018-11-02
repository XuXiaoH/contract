package com.sky.contract.service;

import com.github.pagehelper.PageHelper;
import com.sky.contract.mapper.InvoiceMapper;
import com.sky.contract.model.Contract;
import com.sky.contract.model.Invoice;
import com.sky.contract.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by shiqm on 2018/9/30.
 */

@Service
public class InvoiceService {

    @Autowired
    private InvoiceMapper invoiceMapper;


    public List<Invoice> getAll() {
        return invoiceMapper.selectAll();
    }

    public List<Invoice> getALlByContract(String contractId) {
        Invoice invoice = new Invoice();
        invoice.setContractId(contractId);
        return invoiceMapper.select(invoice);
    }

    public int count(String contractId) {
        Invoice invoice = new Invoice();
        if (StringUtils.isEmpty(contractId)) {
            invoice.setContractId(contractId);
        }
        return invoiceMapper.selectCount(invoice);
    }

    public void save(Invoice invoice) {
        invoiceMapper.insertSelective(invoice);
    }

    public Invoice get(Long invoiceId) {
        return invoiceMapper.selectByPrimaryKey(invoiceId);
    }

}
