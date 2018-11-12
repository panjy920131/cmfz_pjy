package com.baizhi.test;

import com.baizhi.entity.Banner;
import com.baizhi.service.BannerService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;

public class AdminTest extends BasicTest{
   @Autowired
   private BannerService bannerService;
    @Test
    public void save(){
        Banner b=new Banner();
        b.setTitle("sd");
        b.setCreatTime(new Date());
        b.setStatus("y");
        bannerService.add(b);
        System.out.println(b);
    }
}
