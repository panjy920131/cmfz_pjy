package com.baizhi.service;

import com.baizhi.dao.AdminDao;
import com.baizhi.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminDao adminDao;

    @Override
    public Admin findOne(String id) {
        return adminDao.queryOne(id);
    }

    @Override
    public void motify(String id, String password) {
        adminDao.updatePwd(id,password);
    }

    @Override
    public Admin find(Admin admin) {
        Admin admins=adminDao.queryUsernameAndPassword(admin.getUsername(),admin.getPassword());
        return admins;
        }

    }

