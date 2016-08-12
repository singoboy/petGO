package com.petgo.model;

import org.codehaus.jackson.annotate.JsonCreator;

import java.io.Serializable;

/**
 * Created by Gary on 2016/8/6.
 */
public class Product implements Serializable {
    private int productID;
    private String name;
    private int price;
    private String imageName;
    private String imageUrl;

    //Jackson 需要空的建構子   Gson不用
    public Product() {

    }

    public Product(int productID, String name, int price, String imageName, String imageUrl) {
        super();
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.imageName=imageName;
        this.imageUrl = imageUrl;
    }

    @Override
    // 要比對欲加入商品與購物車內商品的id是否相同，是則值相同
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || !(obj instanceof OrderProduct)) {
            return false;
        }

        return this.getProductID() == ((Product) obj).getProductID();
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "Product{" +
                "imageUrl='" + imageUrl + '\'' +
                ", productID=" + productID +
                ", name='" + name + '\'' +
                ", price=" + price +
                '}';
    }
}
