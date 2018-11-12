package com.baizhi.service;

import com.baizhi.entity.Chapter;

import java.util.List;

public interface ChapterService {
    void add(Chapter chapter);
    void remove(String id);
    void motify(Chapter chapter);
    Chapter findOne(String id);
    List<Chapter> findAll();
    List<Chapter> findByPage(Integer page,Integer rows);
    Long findTotals();

}
