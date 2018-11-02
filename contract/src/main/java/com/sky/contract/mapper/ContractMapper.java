package com.sky.contract.mapper;

import com.sky.contract.model.Contract;
import com.sky.contract.util.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by shiqm on 2018/9/29.
 */

@Mapper
public interface ContractMapper extends BaseMapper<Contract> {

    List<Contract> getContractByUsers(@Param("ids") List<Long> ids,@Param("status") short status);

    List<Contract> getContractByProjectTypeAndContractType(@Param("type") Short type,@Param("contractType") Short contractType);

    List<Contract> getContractByProjectIdAndType(@Param("projectId") Long projectId,@Param("type") Short type);

}
