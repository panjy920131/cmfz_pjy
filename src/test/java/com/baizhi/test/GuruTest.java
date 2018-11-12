package com.baizhi.test;

import com.baizhi.entity.Guru;
import com.baizhi.service.GuruService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class GuruTest extends BasicTest{
    @Autowired
    private GuruService guruService;
    @Test
    public void add(){
        Guru guru=new Guru();
        guru.setNiname("上师仁波切");
        guru.setHeadPic("back/guru/guruImg/4.jpg");
        guru.setSex("男");
        guruService.add(guru);
        System.out.println(guru);
    }
    @Test
    public void delete(){
        guruService.remove("dabfb25b-9445-4eec-b1ed-bc67b6a6bfb4");
    }
    @Test
    public void findByName(){
        List<Guru> gurus=guruService.findByName();
        for (Guru gu:gurus){
            System.out.println(gu);
        }
    }
}
