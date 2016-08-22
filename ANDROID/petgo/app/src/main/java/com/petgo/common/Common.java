package com.petgo.common;

import android.content.Context;
import android.widget.Toast;

import com.petgo.CartActivity;
import com.petgo.ExitActivity;
import com.petgo.MemberActivity;
import com.petgo.MemberLoginActivity;
import com.petgo.ProductListActivity;
import com.petgo.R;
import com.petgo.model.Category;
import com.petgo.model.Member;
import com.petgo.model.OrderProduct;
import com.petgo.model.Product;

import java.util.ArrayList;

/**
 * Created by Gary on 2016/8/6.
 */
public class Common {

    // 模擬器連PHP
    public static String URL = "http://10.0.2.2:8888/petShop/";

    // 功能分類
    public final static Category[] CATEGORIES = {
            new Category(0, "User", R.drawable.users, MemberActivity.class),
            new Category(1, "Products", R.drawable.paw, ProductListActivity.class),
            new Category(2, "Shooping Cart", R.drawable.shopping, CartActivity.class)
            , new Category(3, "   Exit", R.drawable.exit, ExitActivity.class)
            //, new Category(3, "Login", R.drawable.product, MemberLoginActivity.class)
    };

    // 模擬產品清單
    public final static Product[] PRODUCTS = new Product[]{
            new Product(1, "蘑菇", 50,"mushroom.jpeg", "http://localhost:8888/petShop/upload/mushroom.jpeg"),
            new Product(2, "貓罐頭", 100,"catcan.jpeg", "http://localhost:8888/petShop/upload/catcan.jpeg"),
            new Product(3, "狗罐頭", 150, "dogcan.jpeg","http://localhost:8888/petShop/upload/dogcan.jpeg")
    };


    public static Member member  ;

    public static ArrayList<OrderProduct> CART = new ArrayList<>();

    public static void showToast(Context context, int messageResId) {
        Toast.makeText(context, messageResId, Toast.LENGTH_SHORT).show();
    }

    public static void showToast(Context context, String message) {
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show();
    }


}
