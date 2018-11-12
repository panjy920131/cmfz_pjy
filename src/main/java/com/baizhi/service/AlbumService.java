package com.baizhi.service;

import com.baizhi.entity.Album;

import java.util.List;

public interface AlbumService {
    void add(Album album);
    void remove(String id);
    void motify(Album album);
    Album findOne(String id);
    List<Album> findAll();
    List<Album> findByPage(Integer page,Integer rows);
    Long findTotals();
    List<Album> findByName();
}
