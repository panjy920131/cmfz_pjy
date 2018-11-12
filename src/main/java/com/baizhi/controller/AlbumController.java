package com.baizhi.controller;

import com.baizhi.entity.Album;
import com.baizhi.service.AlbumService;
import com.baizhi.util.LoadUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/album")
public class AlbumController {
    @Autowired
    private AlbumService albumService;



    @RequestMapping("/add")
    public @ResponseBody Map<String,Object> add(MultipartFile file, HttpServletRequest request, Album album){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            String upload = LoadUtils.upload(file, request, "back/album/coverImg");
            album.setCoverImg(upload);
            albumService.add(album);
            result.put("success",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/queryAll")
    public @ResponseBody List<Album> queryAll(){
       // return albumService.findAll();
        //当前页
        List<Album> albums = albumService.findAll();
       //集数
        for(Album a:albums){
            //获取章节的长度，并设置到集数中
            a.setCounts(a.getChildren().size());
            //调用update方法，更新数据库信息
            albumService.motify(a);
        }
        return albums;

    }

    @RequestMapping("/remove")
    public @ResponseBody Map<String,Object> remove(String id){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            albumService.remove(id);
            result.put("success",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/motify")
    public @ResponseBody Map<String,Object> motify(Album album){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            albumService.motify(album);
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
                albumService.remove(s);
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
    public @ResponseBody Album findOne(String id){
        return albumService.findOne(id);
    }

    @RequestMapping("/queryByName")
    public @ResponseBody List<Album> queryByName(){
        return  albumService.findByName();
    }
    @RequestMapping("download")
    public @ResponseBody void download(String fileName, String openStyle, HttpServletRequest request, HttpServletResponse response) throws Exception{
        //1.根据接收的文件名去服务中指定目录读取文件
        String realPath=request.getSession().getServletContext().getRealPath("/back/album/coverImg");
        //2.以文件输入流读取文件
        FileInputStream is=new FileInputStream(new File(realPath,fileName));
        //3设置响应头
        response.setHeader("content-disposition",openStyle+";fileName="+ URLEncoder.encode(fileName,"UTF-8"));
        //4.获取响应输出流
        ServletOutputStream os=response.getOutputStream();
        //5.使用IOUtils工具类
        IOUtils.copy(is,os);
        //6关流   安静关流
        IOUtils.closeQuietly(is);
        IOUtils.closeQuietly(os);
    }
}
