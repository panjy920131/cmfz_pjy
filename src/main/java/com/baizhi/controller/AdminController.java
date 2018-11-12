package com.baizhi.controller;

import com.baizhi.entity.Admin;
import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class AdminController {
    @Autowired
    private AdminService adminService;
    //登录
    @RequestMapping("/login")
    public String login(Admin admin, HttpServletRequest request, String code, HttpSession session){

        //验证码
        String img=session.getAttribute("code").toString();
        if(img.equalsIgnoreCase(code)){//忽略大小写
            Admin login=adminService.find(admin);
            if(login!=null&&login.getUsername().length()>0&&login.getPassword().length()>0){
                request.getSession().setAttribute("admin",login);
                return "redirect:/back/main/main.jsp";
            }else{
                return "redirect:/back/login/login.jsp";
            }
        }else{
            return "redirect:/back/login/login.jsp";
        }
    }

    //退出系统
    @RequestMapping("/zhikong")
    public String zhiKong(HttpServletRequest request){
            request.getSession().setAttribute("admin",null);
            return "redirect:/back/login/login.jsp";
    }

    //修改密码
    @RequestMapping("/motify")
    public @ResponseBody
    Map<String,Object> motify(String oldPwd, String id, String password){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            Admin admin = adminService.findOne(id);
            System.out.println("旧密码"+oldPwd);
            System.out.println("新密码"+password);
            System.out.println("id"+id);
            if(oldPwd.equals(admin.getPassword())){
                adminService.motify(id,password);
                result.put("success",true);
                result.put("message","修改成功");
                return  result;
            }else{
                result.put("success",false);
                result.put("message","旧密码输入不正确");
                 return  result;
            }
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
            return result;
        }
}

}

