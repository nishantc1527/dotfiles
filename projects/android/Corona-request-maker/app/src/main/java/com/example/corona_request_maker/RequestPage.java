package com.example.corona_request_maker;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

import com.example.corona_request_maker.server.NetworkUtils;

public class RequestPage extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_request_page);


        findViewById(R.id.submit).setOnClickListener((view) -> {
            TextView titleView = findViewById(R.id.title);
            String title = titleView.getText().toString();

            TextView dataView = findViewById(R.id.date);
            String date = dataView.getText().toString();

            TextView timeView = findViewById(R.id.time);
            String time = timeView.getText().toString();

            TextView taskView = findViewById(R.id.task);
            String task = taskView.getText().toString();

            String username = MainActivity.user.getUsername();

            String phone = MainActivity.user.getPhoneNumber();
            MainActivity.client.sendRequestRequest(new NetworkUtils.RequestRequest(title, date, time, task, new NetworkUtils.User(phone, username, null)));

            Intent intent = new Intent(this, SeeRequests.class);
            startActivity(intent);
        });
    }

}