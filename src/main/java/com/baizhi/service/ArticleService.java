package com.baizhi.service;

import com.baizhi.entity.Article;

import java.util.List;

public interface ArticleService {
    void add(Article article);
    void remove(String id);
    void motify(Article article);
    Article findOne(String id);
    List<Article> findAll();
    List<Article> findByPage(Integer page,Integer rows);
    Long findTotals();
}
