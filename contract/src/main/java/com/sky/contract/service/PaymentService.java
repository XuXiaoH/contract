package com.sky.contract.service;

import com.sky.contract.mapper.PaymentMapper;
import com.sky.contract.model.Payment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * Created by shiqm on 2018/9/30.
 */

@Service
public class PaymentService {

    @Autowired
    private PaymentMapper paymentMapper;

    public List<Payment> getAll(){
        return paymentMapper.selectAll();
    }


    public List<Payment> getAllByInvoice(Long invoiceId) {
        Payment payment = new Payment();
        payment.setInvoiceId(invoiceId);
        return paymentMapper.select(payment);
    }

    public void save(Payment payment){
        paymentMapper.insertSelective(payment);
    }

    public boolean updateStatus(Long paymentId,Short status){
        Payment payment=new Payment();
        payment.setPaymentId(paymentId);
        payment.setStatus(status);
        if (paymentMapper.updateByPrimaryKeySelective(payment)==1){
            return true;
        }
        return false;
    }

    public boolean updateNote(Payment payment){
        if (paymentMapper.updateByPrimaryKeySelective(payment)==1){
            return true;
        }
        return false;
    }

    public Payment getpay(Long paymentId){
        return paymentMapper.selectByPrimaryKey(paymentId);
    }

}
