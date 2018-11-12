package com.baizhi.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BaseDao<T> {
      void insert(T t);
      void update(T t);
      void delete(String id);
      T queryOne(String id);
      T queryUsernameAndPassword(@Param("username") String username,@Param("password") String password);
      T queryByPhoneNum(@Param("phoneNum") String phoneNum,@Param("password") String password);
      List<T> queryAll();
      List<T> queryByName();
      List<T> queryByPage(@Param("start") Integer start, @Param("rows") Integer rows);
      Long queryTotals();
}
