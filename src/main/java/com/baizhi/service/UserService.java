package com.baizhi.service;

import com.baizhi.entity.User;

import java.util.List;

public interface UserService {
    User find(User user);
    void add(User user);
    void remove(String id);
    void motify(User user);
    User findOne(String id);
    List<User> findByPage(Integer page,Integer rows);
    Long findTotal();
    //User findUserNameAndPsw(String username,String password);
    //User findByPhoneNum(String phoneNum,String password);
}
