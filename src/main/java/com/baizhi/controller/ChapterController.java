package com.baizhi.controller;

import com.baizhi.entity.Chapter;
import com.baizhi.service.ChapterService;
import com.baizhi.util.LoadUtils;
import com.baizhi.util.ReadMp3;
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
@RequestMapping("/chapter")
public class ChapterController {
    @Autowired
    private ChapterService chapterService;

    @RequestMapping("/findAll")
    public @ResponseBody List<Chapter> findAll(){
        return chapterService.findAll();
    }

    @RequestMapping("/add")
    public @ResponseBody Map<String,Object> add(MultipartFile file, HttpServletRequest request, Chapter chapter){
        Map<String,Object> result=new HashMap<String, Object>();
        try{
            String upload = LoadUtils.upload(file, request, "back/album/coverImg");
            String substring = upload.substring(upload.lastIndexOf("/") + 1);
            synchronized (ReadMp3.read("D:\\cmfz_pjy\\target\\cmfz_pjy\\back\\album\\coverImg\\"+substring)) {
                String read = ReadMp3.read("D:\\cmfz_pjy\\target\\cmfz_pjy\\back\\album\\coverImg\\"+substring);
                chapter.setDuration(read);
            }
            String size = ReadMp3.size("D:\\cmfz_pjy\\target\\cmfz_pjy\\back\\album\\coverImg\\"+substring);
            chapter.setSize(size);
            chapter.setDownPath(substring);
            chapter.setDownPath(substring);
            chapterService.add(chapter);
            result.put("success",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("message",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/motify")
    public @ResponseBody Map<String,Object> motify(Chapter chapter){
        Map<String, Object> result=new HashMap<String, Object>();
        try{
            chapterService.motify(chapter);
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
            chapterService.remove(id);
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
                chapterService.remove(s);
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
    public @ResponseBody Chapter findOne(String id){
        return chapterService.findOne(id);
    }
/*   @RequestMapping("/download")
    public void download(String openStyle, String fileName, HttpServletRequest request, HttpServletResponse response) throws IOException {
        //打开对应文件夹
        String realPath=request.getSession().getServletContext().getRealPath(fileName);
        //以文件输出流读取文件
        File file = new File(realPath);
        FileInputStream fis = new FileInputStream(file);
        //设置响应头
        response.setHeader("content-disposition", openStyle+";fileName="+ URLEncoder.encode(fileName, "UTF-8"));
        //获取响应输出流
        ServletOutputStream os = response.getOutputStream();
        IOUtils.copy(fis.os);
        IOUtils.closeQuietly(fis);
        IOUtils.closeQuietly(os);
    }*/

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
        org.apache.commons.io.IOUtils.copy(is,os);
        //6关流   安静关流
        org.apache.commons.io.IOUtils.closeQuietly(is);
        org.apache.commons.io.IOUtils.closeQuietly(os);
    }

}
