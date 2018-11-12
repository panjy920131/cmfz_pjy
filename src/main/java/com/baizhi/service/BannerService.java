package com.baizhi.service;

import com.baizhi.entity.Banner;

import java.util.List;

public interface BannerService {
    void add(Banner banner);
    void motify(Banner banner);
    void remove(String id);
    Banner findOne(String id);
    List<Banner> findByPage(Integer page, Integer rows);
    Long findTotal();
}
