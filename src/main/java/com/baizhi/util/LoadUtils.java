package com.baizhi.util;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

public class LoadUtils {
    public static  String upload(MultipartFile file, HttpServletRequest request,String fileName) throws Exception, IOException {
        try {
            //获取上传路径  相对路径 files    获取绝对路径
            String real = request.getSession().getServletContext().getRealPath("/" + fileName);
            System.out.println("ewjkaehehqkwehqlwjhrqewhjqe"+real);
            //上传
            file.transferTo(new File(real,file.getOriginalFilename()));
            return ""+fileName+"/"+file.getOriginalFilename();
        } catch (Exception e) {
            e.printStackTrace();
            return  null;
        }
    }
}
    /*//检测文件大小和时长
    public static String audioLength(String filename,HttpServletRequest request) throws Exception{
        String realPath = request.getSession().getServletContext().getRealPath(filename);
        FileInputStream fis;
        int time = 0;
        try {
            fis = new FileInputStream(new File(realPath));
            int b = fis.available();
            Bitstream bt = new Bitstream(fis);
            Header h = bt.readFrame();
            time = (int) h.total_ms(b);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (BitstreamException e) {
            e.printStackTrace();

        }
        int min = time/1000/60; //s
        int second = time/1000%60;
        return min+"分"+second+"秒";

    }
    public static Double audioSize(String filename, HttpServletRequest request) throws Exception {

        String realPath = request.getSession().getServletContext().getRealPath(filename);

        File file = new File(realPath);
        long size = file.length();
        long l = size / 1024 ;
        Double aDouble = Double.valueOf(l);
        Double size1 = aDouble/1024;
        Double dou = (double)Math.round(size1*100)/100;
        return dou;
    }
}
*/