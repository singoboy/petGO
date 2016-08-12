package com.petgo.model;

import com.petgo.model.Product;

/**
 * Created by Gary on 2016/8/7.
 */
public class OrderProduct extends Product {
    private int quantity;

    public OrderProduct(int id, String name, int price,String imageName,String imageUrl, int quantity) {
        super(id, name, price,imageName,imageUrl);
        this.quantity = quantity;
    }

    public OrderProduct(Product product, int quantity) {
        this(product.getProductID(), product.getName(), product.getPrice(), product.getImageName(),product
                .getImageUrl(), quantity);
        this.quantity = quantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

}