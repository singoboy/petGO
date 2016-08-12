package com.petgo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import com.petgo.common.Common;
import com.petgo.model.Member;
import com.petgo.model.Product;
import com.petgo.task.MemberCheckTask;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.ExecutionException;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class MemberLoginActivity extends AppCompatActivity {

    EditText  edAccount,edPassword;
    Member member;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_login);
        findViews();
        setResult(RESULT_CANCELED);  //使用者按下返回鍵
    }


    private void findViews(){
        edAccount = (EditText) findViewById(R.id.edAccount);
        edPassword = (EditText) findViewById(R.id.edPassword);

    }

    //Here is workaround  Because  of  PHP!!

    public void login(View view){

        //先做輸入檢查
        if (edAccount.getText().toString().length() == 0 || edPassword.getText().toString().length() == 0  ){
            Common.showToast(this,"請輸入帳密");
            return;
        }

        //先 到DB check

        String returnString = "";
        member = new Member();
        member.setMemberAccount(edAccount.getText().toString());
        member.setMemberPass(edPassword.getText().toString());

        String url = Common.URL + "member_check_get.php";

        checkExist(url);

    }


    public void checkExist(String url){
        OkHttpClient  mOkHttpClient = new OkHttpClient();
        RequestBody formBody = new FormBody.Builder()
                .add("account", member.getMemberAccount())
                .add("password", member.getMemberPass())
                .build();
        Request request = new Request.Builder()
                .url(url)
                .post(formBody)
                .build();
        Call call = mOkHttpClient.newCall(request);

        call.enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {

                Toast.makeText(getApplicationContext(), "連線失敗", Toast.LENGTH_SHORT).show();

            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                String str = response.body().string();

                if (str.equals("ok"))
                {
                    getMember ();


                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                         //   Common.member=member;
                            Toast.makeText(getApplicationContext(), "登入成功", Toast.LENGTH_SHORT).show();
                            setResult(RESULT_OK);
                            finish();
                        }
                    });
            }
                else{

                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            Toast.makeText(getApplicationContext(), "帳密錯誤", Toast.LENGTH_SHORT).show();
                        }
                    });

                }
            }

        });


    }


    
    public void  getMember (){

        String url =  Common.URL + "member_get.php";
        OkHttpClient  mOkHttpClient = new OkHttpClient();
        RequestBody formBody = new FormBody.Builder()
                .add("account", member.getMemberAccount())
                .add("password", member.getMemberPass())
                .build();
        Request request = new Request.Builder()
                .url(url)
                .post(formBody)
                .build();

        try {
            Response response = mOkHttpClient.newCall(request).execute();
            Common.member =  parseJackson(response.body().string());

        } catch (IOException e) {
            e.printStackTrace();

        }

    }


    private Member parseJackson(String s){
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            ArrayList<Member> list =
                    objectMapper.readValue(s,
                            new TypeReference<List<Member>>(){});

            return list.get(0);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

}
