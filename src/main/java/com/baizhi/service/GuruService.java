package com.baizhi.service;

import com.baizhi.entity.Guru;

import java.util.List;

public interface GuruService {
    void add(Guru guru);
    void motify(Guru guru);
    void remove(String id);
    Guru findOne(String id);
    List<Guru> findByPage(Integer page,Integer rows);
    Long findTotals();
    List<Guru> findByName();
}
