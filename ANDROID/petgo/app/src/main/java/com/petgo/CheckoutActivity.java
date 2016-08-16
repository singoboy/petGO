package com.petgo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.petgo.common.Common;
import com.petgo.model.OrderProduct;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class CheckoutActivity extends AppCompatActivity {

    private TextView tvName ,tvTotal;
    EditText edAddr;
    int total ;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_checkout);
        findViews();
        total = showTotal(Common.CART);
        findViewById(R.id.loadingPanel).setVisibility(View.GONE);
    }

    @Override
    protected void onStart() {
        super.onStart();
        tvName.setText(Common.member.getMemberName());
        tvTotal.setText(String.valueOf(total));
    }


     //This is workaround Because of PHP !!
    //FIXME should  request JSON do Once and response Once
    public void buy(View view){

        if (edAddr.getText().toString().length()== 0){
            Common.showToast(this,"請輸入地址");
            return;
        }

        addOrder();

    }


    public void getMemAddr(View view){
        edAddr.setText(Common.member.getMemberAddr());
    }

    private void findViews(){
        tvName = (TextView) findViewById(R.id.tvName);
        tvTotal = (TextView) findViewById(R.id.tvTotal);
        edAddr = (EditText) findViewById(R.id.edAddr);
    }


    private int showTotal(List<OrderProduct> orderProductList) {
        int total = 0;
        for (OrderProduct orderProduct : orderProductList) {
            total += orderProduct.getPrice() * orderProduct.getQuantity();
        }
        return total;
    }


    private void addOrder(){
        findViewById(R.id.loadingPanel).setVisibility(View.VISIBLE);
        String url = Common.URL + "order_add.php";
        OkHttpClient mOkHttpClient = new OkHttpClient();
        RequestBody formBody = new FormBody.Builder()
                .add("total", String.valueOf(total))
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

                Toast.makeText(getApplicationContext(), "連線失敗", Toast.LENGTH_SHORT).show();

            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                String returnStr = response.body().string();

                if (!returnStr.equals("error"))
                {

                    addDetails(returnStr);

                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            //   Common.member=member;
                            Common.CART.clear();
                            findViewById(R.id.loadingPanel).setVisibility(View.GONE);

                            setResult(RESULT_OK);  // or go to view MainActivity?
                            finish();
                        }
                    });
                }
                else{

                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            findViewById(R.id.loadingPanel).setVisibility(View.GONE);
                            Toast.makeText(getApplicationContext(), "連線失敗", Toast.LENGTH_SHORT).show();
                        }
                    });

                }
            }

        });


    }


    private void addDetails(String OrderStr){

        String url =  Common.URL + "detail_add_android.php";

        ArrayList<OrderProduct> orderProductList = Common.CART;

        for (int i = 0 ; i<orderProductList.size();i++) {
            OrderProduct orderProduct  = orderProductList.get(i);
            int itemTotal = orderProduct.getQuantity()*orderProduct.getPrice();

            OkHttpClient mOkHttpClient = new OkHttpClient();
            RequestBody formBody = new FormBody.Builder()
                    .add("orderID", OrderStr)
                    .add("productID", String.valueOf(orderProduct.getProductID()))
                    .add("name", orderProduct.getName())
                    .add("price", String.valueOf(orderProduct.getPrice()))
                    .add("quantity", String.valueOf(orderProduct.getQuantity()))
                    .add("itemTotal", String.valueOf(itemTotal))
                    .build();
            Request request = new Request.Builder()
                    .url(url)
                    .post(formBody)
                    .build();

            try {
                Response response = mOkHttpClient.newCall(request).execute();

            } catch (IOException e) {
                e.printStackTrace();

            }

        }
    }

}
