package com.baizhi.dao;

import com.baizhi.entity.Admin;
import org.apache.ibatis.annotations.Param;

public interface AdminDao extends BaseDao<Admin> {
    void updatePwd(@Param("id") String id, @Param("password") String password);
}
