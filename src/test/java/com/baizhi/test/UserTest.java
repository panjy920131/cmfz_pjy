package com.baizhi.test;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
import java.util.List;

public class UserTest extends BasicTest {
    @Autowired
    private UserService userService;
    @Test
    public void save(){
        User user=new User();
        user.setPhoneNum("15563354545");
        user.setPassword("123");
        user.setUsername("hu");
        user.setProvince("浙江");
        user.setCity("杭州");
        user.setNickName("小明");
        user.setSex("男");
        user.setHeadPic("back/user/img/3.jpg");
        user.setJoinTime(new Date());
        userService.add(user);
        System.out.println(user);
    }
    @Test
    public void delete(){
        userService.remove("e6e9c823-bb52-4024-8aa6-731386bc47d8");
    }
   @Test
    public void findAll(){
        List<User> users= userService.findByPage(1,2);
       System.out.println(users);

   }
}
