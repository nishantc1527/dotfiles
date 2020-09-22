package com.example.corona_request_maker;

import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class ViewRequestActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_view_request);

        TextView title = findViewById(R.id.title);
        title.setText(getIntent().getExtras().getString("title"));

        TextView username = findViewById(R.id.username);
        username.setText(getIntent().getExtras().getString("date"));

        TextView date = findViewById(R.id.date);
        date.setText(getIntent().getExtras().getString("time"));

        TextView task = findViewById(R.id.task);
        task.setText(getIntent().getExtras().getString("task"));

        TextView name = findViewById(R.id.name);
        name.setText(getIntent().getExtras().getString("username"));

        TextView phone = findViewById(R.id.his_phone_number);
        phone.setText(getIntent().getExtras().getString("phone"));

        TextView time = findViewById(R.id.time);
        time.setText(getIntent().getExtras().getString("time"));

        String password = getIntent().getExtras().getString("password");

        findViewById(R.id.accept).setOnClickListener(
                (view) -> {
                    title.setText(title.getText() + " [RESOLVED]");
                }
        );
    }
}