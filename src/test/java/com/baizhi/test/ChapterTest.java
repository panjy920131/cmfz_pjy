package com.baizhi.test;

import com.baizhi.entity.Chapter;
import com.baizhi.service.ChapterService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
import java.util.List;

public class ChapterTest extends BasicTest {
    @Autowired
    private ChapterService chapterService;
    @Test
    public void save(){
        Chapter chapter=new Chapter();
        chapter.setSize("3.5M");
        chapter.setDuration("3");
        chapter.setDownPath("sda");
        chapter.setUploadTime(new Date());
        chapterService.add(chapter);
        System.out.println(chapter);
    }



    @Test
    public void delete(){
        chapterService.remove("8ed88cde-253c-4fce-973d-a61276b4504b");
    }
}
