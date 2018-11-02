package com.sky.contract.service;

import com.sky.contract.mapper.ProjectMapper;
import com.sky.contract.model.Project;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by shiqm on 2018/9/29.
 */

@Service
public class ProjectService {

    @Autowired
    private ProjectMapper projectMapper;

    @Autowired
    private UserService userService;


    public void save(Project project){
        projectMapper.insertSelective(project);
    }


    public List<Project> getAll(){
        return projectMapper.getAllProject();
    }


    public Project get(Long projectId){
        return projectMapper.getProject(projectId);
    }


    public List<Project> getMyProject(){
        List<Long> ids = userService.getMyIds();
        return projectMapper.getProjectByUsers(ids);
    }

    public List<Project> getMyProjectByStatus(Short status){
        List<Long> ids = userService.getMyIds();
        return projectMapper.getProjectByUsersAndStatus(ids,status);
    }

    public boolean updateStatus(Long projectId,Short status){
        Project project=new Project();
        project.setProjectId(projectId);
        project.setStatus(status);
        if(projectMapper.updateByPrimaryKeySelective(project)==1){
            return true;
        }
        return false;
    }






}
