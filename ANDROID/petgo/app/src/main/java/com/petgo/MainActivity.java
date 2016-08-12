package com.petgo;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.TextView;

import com.petgo.model.Category;

import static com.petgo.common.Common.CATEGORIES;

public class MainActivity extends AppCompatActivity {

        String[] func = {"餘額查詢", "交易明細", "最新消息", "投資理財", "離開"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        GridView grid = (GridView)findViewById(R.id.grid);
        grid.setAdapter(new MyGridViewAdapter(this));
        grid.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View v,
                                    int position, long id) {
                Class<? extends Activity> activityClass = CATEGORIES[position]
                        .getThisActivity();
                Intent intent = new Intent(MainActivity.this, activityClass);
                startActivity(intent);
            }
        });
    }

    private class MyGridViewAdapter extends BaseAdapter {
        private LayoutInflater layoutInflater;

        public MyGridViewAdapter(Context context) {
            layoutInflater = LayoutInflater.from(context);
        }

        @Override
        public int getCount() {
            return CATEGORIES.length;
        }

        @Override
        public Object getItem(int position) {
            return CATEGORIES[position];
        }

        @Override
        public long getItemId(int position) {
            return position;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            if (convertView == null) {
                convertView = layoutInflater.inflate(
                        R.layout.grid_item, parent, false);
            }
            Category category = CATEGORIES[position];
            ImageView gImage = (ImageView) convertView
                    .findViewById(R.id.gImage);
            gImage.setImageResource(category.getImage());
            TextView gTitle = (TextView) convertView
                    .findViewById(R.id.gTitle);
            gTitle.setText(category.getTitle());
            return convertView;
        }
    }

}
