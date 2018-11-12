package com.baizhi.controller;

import com.baizhi.entity.Course;
import com.baizhi.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/course")
public class CourseController {
    @Autowired
    private CourseService courseService;
    @RequestMapping("/add")
    public @ResponseBody Map<String,Object> add(Course course){
        Map<String,Object> result=new HashMap<String,Object>();
        try{
            courseService.add(course);
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
            courseService.remove(id);
            result.put("success",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/motify")
    public @ResponseBody Map<String,Object> motify(Course course){
        Map<String,Object> result=new HashMap<String,Object>();
        try{
            courseService.motify(course);
            result.put("success",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/findAll")
    public @ResponseBody Map<String,Object> findAll(Integer page,Integer rows){
        Map<String,Object> result=new HashMap<String, Object>();
        List<Course> pages=courseService.findByPage(page,rows);
        Long total=courseService.findTotals();
        result.put("rows",pages);
        result.put("totals",total);
        return result;
    }
    @RequestMapping("/removeAll")
    public @ResponseBody Map<String,Object> removeAll(String[] id){
        Map<String,Object> result=new HashMap<String,Object>();
        try{
            for (int i = 0; i < id.length; i++) {
                String s = id[i];
                courseService.remove(s);
            }
            result.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/findOne")
    public @ResponseBody Course findOne(String id){
        return courseService.findOne(id);
    }
}
