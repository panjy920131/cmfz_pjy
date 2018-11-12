package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import com.baizhi.util.SaltUtils;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/users")
public class UsersController {
    @Autowired
    private UserService userService;
    @RequestMapping("/findOne")
    public String login(User user, HttpServletRequest request){
        User login=userService.find(user);
        if(login!=null&&login.getPhoneNum().length()>0&&login.getPassword().length()>0){
            request.getSession().setAttribute("admin",login);
            return "redirect:/back/main/main.jsp";
        }else{
            return "redirect:/back/login/login.jsp";
        }
    }
    @RequestMapping("/save")
    public @ResponseBody Map<String,Object> register(User user){
        Map<String,Object> result=new HashMap<String,Object>();
        try{
            //加密
            String salt= SaltUtils.getSalt(4);
            String md2Hex = DigestUtils.md2Hex(user.getPassword() + salt);
            user.setSalt(salt);
            user.setPassword(md2Hex);
            userService.add(user);
            result.put("message","注册成功");
        }catch(Exception e){
            e.printStackTrace();
            result.put("message","注册失败");
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/motify")
    public @ResponseBody Map<String,Object> motify(User user){
        Map<String,Object> result=new HashMap<String,Object>();
        try{
            userService.motify(user);
            result.put("message","修改成功");
        }catch(Exception e){
            e.printStackTrace();
            result.put("message","修改失败");
            result.put("message",e.getMessage());
        }
        return result;
    }
}
