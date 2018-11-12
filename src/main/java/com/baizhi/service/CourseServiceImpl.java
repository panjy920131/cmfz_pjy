package com.baizhi.service;

import com.baizhi.dao.CourseDao;
import com.baizhi.entity.Course;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class CourseServiceImpl implements CourseService {
    @Autowired
    private CourseDao courseDao;
    @Override
    public void add(Course course) {
        course.setId(UUID.randomUUID().toString());
        courseDao.insert(course);
    }

    @Override
    public void remove(String id) {
         courseDao.delete(id);
    }

    @Override
    public void motify(Course course) {
         courseDao.update(course);
    }

    @Override
    public List<Course> findAll() {
        return courseDao.queryAll();
    }

    @Override
    public Course findOne(String id) {
        return courseDao.queryOne(id);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<Course> findByPage(Integer page, Integer rows) {
        int start=(page-1)*rows;
        return courseDao.queryByPage(start,rows);
    }

    @Override
    public Long findTotals() {
        return courseDao.queryTotals();
    }
}
