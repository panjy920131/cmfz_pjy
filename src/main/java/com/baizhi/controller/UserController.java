package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import com.baizhi.util.LoadUtils;
import com.baizhi.util.SaltUtils;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/me")
public class UserController {
    @Autowired
    private UserService userService;
    @RequestMapping("/login")
    public String login(User user, HttpServletRequest request){
        User login=userService.find(user);
        if(login!=null&&login.getPhoneNum().length()>0&&login.getPassword().length()>0){
            request.getSession().setAttribute("admin",login);
            return "redirect:/back/main/main.jsp";
        }else{
            return "redirect:/back/login/login.jsp";
        }
    }
    @RequestMapping("/add")
    public @ResponseBody Map<String,Object> add(MultipartFile file, HttpServletRequest request,User user){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            //加密
            String salt= SaltUtils.getSalt(4);
            String md2Hex = DigestUtils.md2Hex(user.getPassword() + salt);
            user.setSalt(salt);
            user.setPassword(md2Hex);

            //上传图片
            String upload = LoadUtils.upload(file, request, "back/user/img");
            user.setHeadPic(upload);
            userService.add(user);
            result.put("success",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/remove")
    public @ResponseBody Map<String,Object> remove(String id){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            userService.remove(id);
            result.put("success",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/motify")
    public @ResponseBody Map<String,Object> motify(User user){
        Map<String,Object> result=new HashMap<String,Object>();
        try{
            userService.motify(user);
            result.put("success",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/findAll")
    public @ResponseBody Map<String,Object> findByPage(Integer page,Integer rows){
        Map<String,Object> result=new HashMap<String,Object>();
        List<User> pages=userService.findByPage(page,rows);
        Long totals=userService.findTotal();
        result.put("total",totals);
        result.put("rows",pages);
        return result;
    }
    @RequestMapping("/removeAll")
    public @ResponseBody Map<String,Object> removeAll(String[] id){
        Map<String,Object> result=new HashMap<String,Object>();
        try{
            for (int i = 0; i < id.length; i++) {
                String s = id[i];
                userService.remove(s);
            }

            result.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/queryOne")
    public @ResponseBody User findOne(String id){
        return userService.findOne(id);
    }
}
