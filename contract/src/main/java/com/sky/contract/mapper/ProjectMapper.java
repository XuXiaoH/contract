package com.sky.contract.mapper;

import com.sky.contract.model.Project;
import com.sky.contract.util.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by shiqm on 2018/9/29.
 */

@Mapper
public interface ProjectMapper extends BaseMapper<Project> {


    List<Project> getAllProject();

    Project getProject(@Param("projectId")Long projectId);

    List<Project> getProjectByUsers(@Param("ids") List<Long> ids);

    List<Project> getProjectByUsersAndStatus(@Param("ids") List<Long> ids,@Param("status") Short status);

}
