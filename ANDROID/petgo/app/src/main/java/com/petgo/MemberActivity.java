package com.petgo;

import android.app.Activity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import com.petgo.common.Common;

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
        
    }

    public void register(View view){
        Log.i("register", "register: ");
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode ==  REQUEST_LOGIN && resultCode == Activity.RESULT_OK){
            //登入完成後
            tvName.setText(Common.member.getMemberName());
        }


    }


}
