package com.baizhi.service;

import com.baizhi.dao.UserDao;
import com.baizhi.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public User find(User user) {
        User users=userDao.queryByPhoneNum(user.getPhoneNum(),user.getPassword());
        return users;
    }

    @Override
    public void add(User user) {
        user.setId(UUID.randomUUID().toString());
        userDao.insert(user);
    }

    @Override
    public void remove(String id) {
         userDao.delete(id);
    }

    @Override
    public void motify(User user) {
         userDao.update(user);
    }

    @Override
    public User findOne(String id) {
        return userDao.queryOne(id);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<User> findByPage(Integer page, Integer rows) {
        int start=(page-1)*rows;
        return userDao.queryByPage(start,rows);
    }

  /*  @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public User findUserNameAndPsw(String username, String password) {
        return userDao.queryUsernameAndPassword(username,password);
    }*/

    @Override
    public Long findTotal() {
        return userDao.queryTotals();
    }
}
