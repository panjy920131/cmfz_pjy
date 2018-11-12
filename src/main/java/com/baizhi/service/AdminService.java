package com.baizhi.service;

import com.baizhi.entity.Admin;

public interface AdminService{
      Admin find(Admin admin);
      void motify(String id,String password);
      Admin findOne(String id);
}
