package com.petgo.task;

import android.os.AsyncTask;
import android.util.Log;

import com.petgo.model.Product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.JavaType;
import org.codehaus.jackson.type.TypeReference;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
/**
 * Created by user12 on 16/8/9.
 */

public class ProductGetAllTask extends AsyncTask<String,Void,List<Product>>{

    @Override
    protected List<Product> doInBackground(String... strings) {
        String urlStr = strings[0];
        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url(urlStr)
                .build();
        try {
            Response response = client.newCall(request).execute();
         //   Log.i("here",  response.body().string());
            return parseJackson(response.body().string());
          //  return parseGson(response.body().string());

        } catch (IOException e) {
            e.printStackTrace();
            return  Collections.emptyList();
        }

    }

    @Override
    protected void onPostExecute(List<Product> products) {
        super.onPostExecute(products);
    }



    private List<Product> parseJackson(String s){
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            ArrayList<Product> list =
                    objectMapper.readValue(s,
                            new TypeReference<List<Product>>(){});
            Log.d("JSON",list.size()+"/"+list.get(0));
            return list;
        } catch (IOException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    private List<Product> parseGson(String s){
        Gson gson = new Gson();
        ArrayList<Product> list =
                gson.fromJson(s,
                        new TypeToken<ArrayList<Product>>(){}.getType());
        Log.d("JSON",list.size()+"/"+list.get(0));
        return  list;
    }

}
