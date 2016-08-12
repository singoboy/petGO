package com.petgo;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.petgo.common.Common;
import com.petgo.model.OrderProduct;
import com.petgo.model.Product;
import com.petgo.task.ProductGetAllTask;

import java.util.List;
import java.util.concurrent.ExecutionException;

import static com.petgo.common.Common.*;

public class ProductListActivity extends AppCompatActivity {

    private RecyclerView rvProduct;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_product_list);
        rvProduct = (RecyclerView) findViewById(R.id.productListView);
        rvProduct.setLayoutManager(new LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false));
    }


    @Override
    protected void onStart() {
        super.onStart();

        String url = Common.URL + "product_json.php";
        List<Product> products = null;
        try {
            products  =new ProductGetAllTask().execute(url).get();
        } catch (InterruptedException e) {
            e.printStackTrace();
            Log.e("InterruptedException", e.toString());
        } catch (ExecutionException e) {
            e.printStackTrace();
            Log.e("ExecutionException", e.toString());
        }

        if (products == null || products.isEmpty()) {
            Common.showToast(ProductListActivity.this, R.string.msg_NoProductsFound);
        } else {
            rvProduct.setAdapter(new ProductsRecyclerViewAdapter(ProductListActivity.this, products));
        }

        //       products = Arrays.asList(PRODUCTS) ;
        //Log.i("products", products.toString());

        rvProduct.setAdapter(new ProductsRecyclerViewAdapter(ProductListActivity.this, products));


    }

    private class ProductsRecyclerViewAdapter extends RecyclerView.Adapter<ProductsRecyclerViewAdapter.ViewHolder> {
        private Context context;
        private LayoutInflater layoutInflater;
        private List<Product> products;

        public ProductsRecyclerViewAdapter(Context context, List<Product> products) {
            this.context = context;
            layoutInflater = LayoutInflater.from(context);
            this.products = products;
        }

        class ViewHolder extends RecyclerView.ViewHolder {
            ImageView ivProduct, ivAdd;
            TextView tvName, tvPrice;

            public ViewHolder(View itemView) {
                super(itemView);
                ivProduct = (ImageView) itemView.findViewById(R.id.ivProduct);
                ivAdd = (ImageView) itemView.findViewById(R.id.ivAdd);
                tvName = (TextView) itemView.findViewById(R.id.tvTotalPrice);
                tvPrice = (TextView) itemView.findViewById(R.id.tvPrice);
            }
        }

        @Override
        public int getItemCount() {
            return products.size();
        }

        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View itemView = layoutInflater.inflate(R.layout.product_rv_item, parent, false);
            return new ViewHolder(itemView);
        }

        @Override
        public void onBindViewHolder(ViewHolder viewHolder, int position) {
            final Product product = products.get(position);
            Log.i("product",product.toString());
            int id = product.getProductID();
            viewHolder.ivProduct.setImageResource(R.drawable.default_image);
            viewHolder.tvName.setText(product.getName());
            viewHolder.tvPrice.setText(String.valueOf(product.getPrice()));
            viewHolder.ivAdd.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    int index = CART.indexOf(product);
                    if (index == -1) {
                        OrderProduct orderProduct = new OrderProduct(product, 1);
                        CART.add(orderProduct);
                    } else {
                        OrderProduct orderProduct = CART.get(index);
                        orderProduct.setQuantity(orderProduct.getQuantity() + 1);
                    }
                    String text = "";
                    for (OrderProduct orderProduct : CART) {
                        text += "\n-" + orderProduct.getName() + " x "
                                + orderProduct.getQuantity();
                    }
                    String message = getString(R.string.cartContents) + " " + text;
                    new AlertDialog.Builder(context)
                            .setIcon(R.drawable.cart)
                            .setTitle(
                                    getString(R.string.cartAdd) + "\n「"
                                            + product.getName() + "」")
                            .setMessage(message)
                            .setNeutralButton(R.string.text_btConfirm,
                                    new DialogInterface.OnClickListener() {
                                        @Override
                                        public void onClick(
                                                DialogInterface dialog,
                                                int which) {
                                            dialog.cancel();
                                        }
                                    }).show();
                }
            });

        }


    }


}
