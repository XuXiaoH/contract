package com.sky.contract.util;

import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.common.MySqlMapper;

/**
 * Created by shiqm on 2018/9/13.
 */
public interface BaseMapper<T> extends Mapper<T>,MySqlMapper<T> {
}
