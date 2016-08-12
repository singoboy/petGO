package com.petgo;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;
import com.petgo.common.Common;
import java.util.List;

import static com.petgo.common.Common.*;
import com.petgo.model.OrderProduct;

public class CartActivity extends AppCompatActivity {
    private final static int REQUEST_CHECKOUT = 1;
    private RecyclerView rvLists;
    private LinearLayout layoutEmpty;
    private TextView tvTotal;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_cart);
        findViews();
    }

    @Override
    protected void onStart() {
        super.onStart();
        showTotal(CART);
        rvLists.setAdapter(new CartRecyclerViewAdapter(this, CART));
    }


    private void findViews() {
        layoutEmpty = (LinearLayout) findViewById(R.id.layoutEmpty);
        tvTotal = (TextView) findViewById(R.id.tvTotal);
        rvLists = (RecyclerView) findViewById(R.id.rvLists);
        rvLists.setLayoutManager(new LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false));
    }



    private void showTotal(List<OrderProduct> orderProductList) {
        int total = 0;
        for (OrderProduct orderProduct : orderProductList) {
            total += orderProduct.getPrice() * orderProduct.getQuantity();
        }
        tvTotal.setText("Total: " + total);
    }

    public void onCheckoutClick(View view) {
        if (CART == null || CART.size() <= 0) {
            Common.showToast(this, R.string.cartEmpty);
            return;
        }

        // 這裡要判斷 有無登入 沒登入請他先登入
        if (Common.member == null ) {
            Common.showToast(this, "請先登入");
            return;

        }
        //導致結帳頁
        Intent loginIntent = new Intent(this, CheckoutActivity.class);
        startActivityForResult(loginIntent, REQUEST_CHECKOUT);
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode ==  REQUEST_CHECKOUT && resultCode == Activity.RESULT_OK){
            //訂單完成後
            Log.i("取得登入資料後","取得登入資料後");
            finish();


        }


    }

    public void onEmptyCartClick(View view) {
        if (CART == null || CART.size() <= 0) {
            Common.showToast(this, R.string.cartEmpty);
            return;
        }
        String message = getString(R.string.msg_ClearCart);
        new AlertDialog.Builder(this)
                .setIcon(R.drawable.cart)
                .setTitle(R.string.btClearCart)
                .setMessage(message)
                .setPositiveButton(R.string.text_btConfirm,
                        new DialogInterface.OnClickListener() {

                            @Override
                            public void onClick(DialogInterface dialog,
                                                int which) {
                                CART.clear();
                                showTotal(CART);
                                rvLists.getAdapter().notifyDataSetChanged();
                            }
                        })

                .setNegativeButton(R.string.text_btNo,
                        new DialogInterface.OnClickListener() {

                            @Override
                            public void onClick(DialogInterface dialog,
                                                int which) {
                                dialog.cancel();
                            }
                        }).setCancelable(false).show();
    }

    private class CartRecyclerViewAdapter extends RecyclerView.Adapter<CartRecyclerViewAdapter.ViewHolder>{

        private Context context;
        private LayoutInflater layoutInflater;
        private List<OrderProduct> orderProducts;


        // Constructor
        public CartRecyclerViewAdapter(Context context, List<OrderProduct> orderProducts) {
            this.context = context;
            layoutInflater = LayoutInflater.from(context);
            this.orderProducts = orderProducts;
        }

        //內部類別
        class ViewHolder extends RecyclerView.ViewHolder {
            View itemView;
            ImageView ivProduct;
            ImageView ivRemove;
            TextView tvName;
            TextView tvPrice;
            Spinner spQty;

            public ViewHolder(View itemView) {
                super(itemView);
                this.itemView = itemView;
                ivProduct = (ImageView) itemView.findViewById(R.id.ivProduct);
                ivRemove = (ImageView) itemView.findViewById(R.id.ivRemove);
                tvName = (TextView) itemView.findViewById(R.id.tvTotalPrice);
                tvPrice = (TextView) itemView.findViewById(R.id.tvPrice);
                spQty = (Spinner) itemView.findViewById(R.id.spQty);
            }
        }


        @Override
        public CartRecyclerViewAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View itemView = layoutInflater.inflate(R.layout.cart_rv_item, parent, false);
            return new ViewHolder(itemView);
        }

        @Override
        public void onBindViewHolder(CartRecyclerViewAdapter.ViewHolder viewHolder, int position) {
            final OrderProduct orderProduct = orderProducts.get(position);
            viewHolder.ivProduct.setImageResource(R.drawable.default_image);
            viewHolder.tvName.setText(orderProduct.getName());
            viewHolder.tvPrice.setText(String.valueOf(orderProduct.getPrice()));
            viewHolder.spQty.setSelection(orderProduct.getQuantity() -1 , true);  //數量會自動加一
            viewHolder.spQty.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
                    int quantity = Integer.parseInt(adapterView
                            .getItemAtPosition(i).toString());
                    orderProduct.setQuantity(quantity);
                    showTotal(CART);
                    Common.showToast(context,
                            getString(R.string.msg_NewQty) + " " +
                                    orderProduct.getQuantity());
                }

                @Override
                public void onNothingSelected(AdapterView<?> adapterView) {

                }
            });

            viewHolder.ivRemove.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View view) {
                    String message = getString(R.string.cartRemove) + "「"
                            + orderProduct.getName() + "」?";
                    new AlertDialog.Builder(context)
                            .setIcon(R.drawable.cart)
                            .setTitle(R.string.cartRemove)
                            .setMessage(message)
                            .setPositiveButton(R.string.text_btYes,
                                    new DialogInterface.OnClickListener() {
                                        @Override
                                        public void onClick(DialogInterface dialogInterface, int i) {
                                            CART.remove(orderProduct);
                                            showTotal(CART);
                                            CartRecyclerViewAdapter.this
                                                    .notifyDataSetChanged();
                                        }
                                    })
                            .setNegativeButton(R.string.text_btNo,
                                    new DialogInterface.OnClickListener() {
                                        @Override
                                        public void onClick(
                                                DialogInterface dialog,
                                                int which) {
                                            dialog.cancel();
                                        }
                                    }).setCancelable(false).show();

                }
            });
        }

        @Override
        public int getItemCount() {
            if (CART.size() <= 0) {
                layoutEmpty.setVisibility(View.VISIBLE);
            } else {
                layoutEmpty.setVisibility(View.GONE);
            }
            return orderProducts.size();
        }
    }


}
