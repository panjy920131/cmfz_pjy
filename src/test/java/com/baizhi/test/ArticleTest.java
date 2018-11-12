package com.baizhi.test;

import com.baizhi.entity.Article;
import com.baizhi.service.ArticleService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
import java.util.List;

public class ArticleTest extends BasicTest {
    @Autowired
    private ArticleService articleService;
    @Test
    public void save(){
        Article article=new Article();
        article.setTitle("所属");
        article.setContent("sfsf");
        article.setPublishDate(new Date());
        article.setImgPath("back/article/img/A6.jpg");
        articleService.add(article);
        System.out.println(article);
    }
    @Test
    public void delete(){
    articleService.remove("909895c5-b306-4857-8850-8f523c700b2b");

    }
    @Test
    public void queryAll(){
        List<Article> article=articleService.findAll();
        for (Article a:article){
            System.out.println(a);
        }
    }
}
