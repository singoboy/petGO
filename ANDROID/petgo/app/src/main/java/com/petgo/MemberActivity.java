package com.petgo;

import android.app.Activity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.petgo.common.Common;

import java.io.IOException;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import static  com.petgo.common.Common.*;

public class MemberActivity extends AppCompatActivity {
    private final static int REQUEST_LOGIN = 0;
   private TextView tvName ,tvTotalPrice;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member);
        findViews();
    }

    private void findViews(){
        tvName = (TextView) findViewById(R.id.tvName);
        tvTotalPrice = (TextView) findViewById(R.id.tvTotalPrice);
    }

    @Override
    protected void onStart() {
        super.onStart();
        if (Common.member !=null){
            tvName.setText(Common.member.getMemberName());
            getTotal();
        }
//        tvName.setText("您好");
//        tvTotalPrice.setText("2000");

    }

    public void login(View view){     //click method  要設public
        Intent loginIntent = new Intent(this, MemberLoginActivity.class);
        startActivityForResult(loginIntent, REQUEST_LOGIN);

    }

    public void logout(View view){
        Common.member = null;
        tvName.setText("");
        tvTotalPrice.setText("");
        
    }

    public void register(View view){
        Log.i("register", "register: ");
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode ==  REQUEST_LOGIN && resultCode == Activity.RESULT_OK){
            //登入完成後
           // tvName.setText(Common.member.getMemberName());
        }

    }

    private void getTotal(){
        String url =Common.URL+"order_getTotal.php";
        OkHttpClient mOkHttpClient = new OkHttpClient();
        RequestBody formBody = new FormBody.Builder()
                .add("memberID", String.valueOf(Common.member.getMemberID()))
                .build();
        Request request = new Request.Builder()
                .url(url)
                .post(formBody)
                .build();
        Call call = mOkHttpClient.newCall(request);

        call.enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {

                Toast.makeText(getApplicationContext(), "累積金額讀取失敗", Toast.LENGTH_SHORT).show();

            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                final String str = response.body().string();

                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            tvTotalPrice.setText(str);
                        }
                    });

            }

        });

    }


}
