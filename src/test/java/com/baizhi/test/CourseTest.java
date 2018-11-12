package com.baizhi.test;

import com.baizhi.entity.Course;
import com.baizhi.service.CourseService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
import java.util.List;

public class CourseTest extends BasicTest {
    @Autowired
    private CourseService courseService;
    @Test
    public void findAll(){
        List<Course> course=courseService.findAll();
        for (Course cou:course){
            System.out.println(cou);
        }
    }
    @Test
    public void save(){
        Course course=new Course();
        course.setTitle("民国风");
        course.setMarking("y");
        course.setCreateTime(new Date());
        courseService.add(course);
        System.out.println(course);
    }
   @Test
    public void delete(){
        courseService.remove("8bced681-a4ef-4199-a482-1b12393a2bd5");
   }
}
