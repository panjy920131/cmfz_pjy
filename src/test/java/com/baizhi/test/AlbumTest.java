package com.baizhi.test;

import com.baizhi.entity.Album;
import com.baizhi.service.AlbumService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class AlbumTest extends BasicTest {
    @Autowired
    private AlbumService albumService;
    @Test
    public void save(){
        Album album=new Album();
        album.setAuthor("小明");
        album.setBrief("sdshhh");
        album.setBroadCast("小明");
        albumService.add(album);
        System.out.println(album);
    }
    @Test
    public void delete(){
        albumService.remove("df61d245-d436-4742-916e-5f2e911e42de");
    }
    @Test
    public void queryAll(){
        List<Album> albums = albumService.findAll();
        for (Album album : albums) {
            System.out.println(album);
        }
    }

    @Test
    public void query(){
        List<Album> byName = albumService.findByName();
        for (Album album : byName) {
            System.out.println(album);
        }
    }
}
