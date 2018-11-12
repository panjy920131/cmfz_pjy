package com.baizhi.controller;

import com.baizhi.entity.Article;
import com.baizhi.service.ArticleService;
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
@RequestMapping("/article")
public class ArticleController {
    @Autowired
    private ArticleService articleService;
    @RequestMapping("/add")
    public @ResponseBody Map<String,Object> add(MultipartFile file, HttpServletRequest request, Article article){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            String upload = LoadUtils.upload(file, request, "back/album/coverImg");
            article.setImgPath(upload);
            articleService.add(article);
            result.put("success",true);

        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/queryAll")
    public @ResponseBody List<Article> queryAll(){
        return articleService.findAll();
    }

    @RequestMapping("/remove")
    public @ResponseBody Map<String,Object> remove(String id){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            articleService.remove(id);
            result.put("success",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/motify")
    public @ResponseBody Map<String,Object> motify(MultipartFile file, HttpServletRequest request,Article article){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            String upload = LoadUtils.upload(file, request, "back/album/coverImg");
            article.setImgPath(upload);
            articleService.motify(article);
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
                articleService.remove(s);
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
    public @ResponseBody Article findOne(String id){
        return articleService.findOne(id);
    }
}
