package com.baizhi.entity;

import java.util.ArrayList;
import java.util.List;

public class Guru {
    private String id;
    private String niname;
    private String headPic;
    private String sex;
    private List<Article> childrens=new ArrayList<>();

    @Override
    public String toString() {
        return "Guru{" +
                "id='" + id + '\'' +
                ", niname='" + niname + '\'' +
                ", headPic='" + headPic + '\'' +
                ", sex='" + sex + '\'' +
                ", childrens=" + childrens +
                '}';
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNiname() {
        return niname;
    }

    public void setNiname(String niname) {
        this.niname = niname;
    }

    public String getHeadPic() {
        return headPic;
    }

    public void setHeadPic(String headPic) {
        this.headPic = headPic;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public List<Article> getChildrens() {
        return childrens;
    }

    public void setChildrens(List<Article> childrens) {
        this.childrens = childrens;
    }

    public Guru(String id, String niname, String headPic, String sex, List<Article> childrens) {
        this.id = id;
        this.niname = niname;
        this.headPic = headPic;
        this.sex = sex;
        this.childrens = childrens;
    }

    public Guru() {
    }
}
