package com.baizhi.service;

import com.baizhi.entity.Course;

import java.util.List;

public interface CourseService {
    void add(Course course);
    void remove(String id);
    void motify(Course course);
    List<Course> findAll();
    Course findOne(String id);
    List<Course> findByPage(Integer page,Integer rows);
    Long findTotals();
}
