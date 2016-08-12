package com.petgo.model;

import android.app.Activity;

/**
 * Created by Gary on 2016/8/6.
 */
public class Category {
    private int id;
    private String title;
    private int image;
    private Class<? extends Activity> thisActivity;

    public Category(int id, String title, int image,
                    Class<? extends Activity> thisActivity) {
        super();
        this.id = id;
        this.title = title;
        this.image = image;
        this.thisActivity = thisActivity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getImage() {
        return image;
    }

    public void setImage(int image) {
        this.image = image;
    }

    public Class<? extends Activity> getThisActivity() {
        return thisActivity;
    }

    public void setThisActivity(Class<? extends Activity> thisActivity) {
        this.thisActivity = thisActivity;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

}
