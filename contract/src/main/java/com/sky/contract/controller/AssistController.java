package com.sky.contract.controller;

import com.sky.contract.service.FileService;
import com.sky.contract.util.BaseController;
import com.sky.contract.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by daNuo.
 */

@Controller
@RequestMapping("assist")
public class AssistController extends BaseController {

    @Autowired
    private FileService fileService;


    @RequestMapping(value = "uploadPic", method = RequestMethod.POST)
    @ResponseBody
    Result uploadPic(MultipartFile file) {
        String url = fileService.uploadPic(file);
        if (url == null) {
            return new Result("上传失败");
        }
        return new Result().append(url);
    }

    @RequestMapping(value = "uploadPics", method = RequestMethod.POST)
    @ResponseBody
    Result uploadPics(MultipartFile[] files) {
        return new Result(fileService.uploadPic(files));
    }


}
