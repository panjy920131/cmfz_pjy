package com.baizhi.controller;

import com.baizhi.entity.Banner;
import com.baizhi.service.BannerService;
import com.baizhi.util.LoadUtils;
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
@RequestMapping("/banner")
public class BannerController {
    @Autowired
    private BannerService bannerService;
    @RequestMapping("/findAll")
    public @ResponseBody Map<String,Object> findAll(Integer page, Integer rows){
        Map<String,Object> result=new HashMap<String,Object>();
        List<Banner> pages=bannerService.findByPage(page,rows);
        Long totals=bannerService.findTotal();
        result.put("total",totals);
        result.put("rows",pages);
        return result;
    }
    @RequestMapping("/add")
    public @ResponseBody Map<String,Object> add(MultipartFile file, HttpServletRequest request,Banner banner){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            String upload = LoadUtils.upload(file, request, "back/banner/img");
            banner.setImgPath(upload);
            bannerService.add(banner);
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
            bannerService.remove(id);
            result.put("success",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/motify")
    public @ResponseBody Map<String,Object> motify(MultipartFile file, HttpServletRequest request,Banner banner){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            String upload = LoadUtils.upload(file, request, "back/banner/img");
            banner.setImgPath(upload);
            bannerService.motify(banner);
            result.put("success",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/removeAll")
    public @ResponseBody Map<String,Object> removeAll(String[] id){
        Map<String,Object> result=new HashMap<String,Object>();
        try{
            for (int i = 0; i < id.length; i++) {
                String s = id[i];
                bannerService.remove(s);
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
    public @ResponseBody Banner findOne(String id){
        return bannerService.findOne(id);
    }
}
