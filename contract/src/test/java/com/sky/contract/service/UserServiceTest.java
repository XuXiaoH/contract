//package com.sky.contract.service;
//
//import com.sky.contract.mapper.PermissionMapper;
//import com.sky.contract.mapper.UserMapper;
//import com.sky.contract.model.Permission;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//
//import java.util.List;
//
//
///**
// * Created by shiqm on 2018/9/13.
// */
//
//@RunWith(SpringJUnit4ClassRunner.class)
//@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
//public class UserServiceTest {
//
//    @Autowired
//    private UserMapper userMapper;
//
//    @Autowired
//    private PermissionMapper permissionMapper;
//
//    @Test
//    public void getUser(){
//       // System.out.println(userMapper.selectByPrimaryKey(Long.valueOf(1)).getCreateAt());
//
////        List<Permission> list=permissionMapper.getAllPermissions();
////
////        list.forEach(t->{
////            System.out.println(t.getName());
////            t.getList().forEach(p->{
////                System.out.println("---"+p.getName());
////            });
////        });
//
//        permissionMapper.getPermissionsByUid(1L);
//
//
//
//    }
//
//}