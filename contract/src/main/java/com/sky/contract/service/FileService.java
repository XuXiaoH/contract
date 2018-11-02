package com.sky.contract.service;

import com.sky.contract.util.cons.Constant;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by daNuo.
 */

@Service
public class FileService {

    public String uploadPic(MultipartFile file) {
        if (file == null) {
            return null;
        }
        //获取文件 存储位置
        File pathFile = new File(Constant.Picture_Upload.getPath());
        if (!pathFile.exists()) {
            //文件夹不存 创建文件
            pathFile.mkdirs();
        }
        long fileSize = file.getSize();
        if (Constant.Picture_Upload.Limit_Size != 0 && fileSize > Constant.Picture_Upload.Limit_Size) {
            return null;
        }
        String[] nameArr = file.getOriginalFilename().split("\\.");
        String nameTag = nameArr[nameArr.length - 1];
        //todo 不知道用户上传格式，不做格式校验了
        String fileName = System.currentTimeMillis() + "." + nameTag;
        try {
            file.transferTo(new File(Constant.Picture_Upload.getPath() + "/" + fileName));
        } catch (IOException e) {
            return null;
        }
        return fileName;
    }


    public List uploadPic(MultipartFile files[]) {
        if (files == null) {
            return null;
        }
        List list = new ArrayList<String>();
        for (int i = 0; i < files.length; i++) {
            String name = uploadPic(files[i]);
            if (name == null) {
                continue;
            }
            list.add(name);
        }
        return list;
    }

}
