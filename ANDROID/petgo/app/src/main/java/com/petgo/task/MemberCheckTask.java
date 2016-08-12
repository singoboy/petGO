package com.petgo.task;

import com.petgo.common.Common;
import com.petgo.model.Member;
import android.os.AsyncTask;
import android.util.Log;

import java.io.IOException;

import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * Created by user12 on 16/8/10.
 */
public class MemberCheckTask extends AsyncTask<Member,Void ,String> {
    @Override
    protected String doInBackground(Member... members) {

       Member member = members[0];
        Log.d("member",member.toString());

        String url = Common.URL + "member_check_get.php";

        Log.d("url",url);

       OkHttpClient client = new OkHttpClient();
        Log.d("i am there","i am there");

        FormBody.Builder formBuilder = new FormBody.Builder();

// dynamically add more parameter like this:
        formBuilder.add("account", member.getMemberAccount());
        formBuilder.add("password", member.getMemberPass());


        RequestBody formBody = formBuilder.build();

        Request request = new Request.Builder()
                .url(url)
                .post(formBody)
                .build();



        try {
            Response response = client.newCall(request).execute();
        //    Log.i("reponse",response.body().string());
            return response.body().string();
        } catch (IOException e) {
            e.printStackTrace();
            return "error" ;
        }

    }



}
