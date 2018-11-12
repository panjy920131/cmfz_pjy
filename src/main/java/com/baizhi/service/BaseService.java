package com.baizhi.service;

import java.util.List;

public interface BaseService<T> {
    void add(T t);
    void motify(T t);
    void remove(String id);
    List<T> findAll();

}
