package com.baizhi.controller;

import com.baizhi.entity.Guru;
import com.baizhi.service.GuruService;
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
@RequestMapping("/guru")
public class GuruController {
    @Autowired
    private GuruService guruService;
    @RequestMapping("/add")
    public @ResponseBody Map<String,Object> add(MultipartFile file, HttpServletRequest request, Guru guru){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            String upload = LoadUtils.upload(file, request, "back/guru/guruImg");
            guru.setHeadPic(upload);
            guruService.add(guru);
            result.put("success",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/remove")
    public @ResponseBody Map<String, Object> remove(String id){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            guruService.remove(id);
            result.put("success",true);
        }catch(Exception e){
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
                guruService.remove(s);
            }

            result.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/findAll")
    public @ResponseBody Map<String,Object> findByPage(Integer page,Integer rows){
        Map<String,Object> result=new HashMap<String, Object>();
        List<Guru> pages=guruService.findByPage(page,rows);
        Long totals=guruService.findTotals();
        result.put("total",totals);
        result.put("rows",pages);
        return result;
    }
    @RequestMapping("/motify")
    public @ResponseBody Map<String,Object> motify(MultipartFile file, HttpServletRequest request,Guru guru){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            String upload = LoadUtils.upload(file, request, "back/guru/guruImg");
            guru.setHeadPic(upload);
            guruService.motify(guru);
            result.put("success",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/findOne")
    public @ResponseBody Guru findOne(String id){
        return guruService.findOne(id);
    }
    @RequestMapping("/findByName")
    public @ResponseBody List<Guru> findByName(){
        return guruService.findByName();
    }
}
