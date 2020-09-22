package com.example.corona_request_maker;

import android.content.Intent;
import android.os.Bundle;
import android.view.ViewGroup;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;

import com.example.corona_request_maker.server.NetworkUtils;

import java.util.List;

public class SeeRequests extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_see_requests);

        MainActivity.client.listenForRequestRequests(this);
    }

    public void updateScrollRequests(List<NetworkUtils.RequestRequest> requests) {
        ViewGroup layout = findViewById(R.id.linear_scroll);
        if (null != layout && layout.getChildCount() > 0) {
            try {
                layout.removeViews(0, layout.getChildCount());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        for (NetworkUtils.RequestRequest r : requests) {
            Button button = new Button(this);
            button.setText(r.getTitle() + "\n" + r.getDate() + "\n" + r.getTime());

            button.setOnClickListener(
                    view -> {
                        Intent intent = new Intent(SeeRequests.this, ViewRequestActivity.class);

                        intent.putExtra("title", r.getTitle());
                        intent.putExtra("date", r.getDate());
                        intent.putExtra("time", r.getTime());
                        intent.putExtra("task", r.getTask());
                        intent.putExtra("username", r.getUser().getUsername());
                        intent.putExtra("phone", r.getUser().getPhoneNumber());
                        intent.putExtra("password", r.getUser().getPassword());

                        button.setOnClickListener(
                                view1 -> startActivity(intent)
                        );
                    }
            );

            runOnUiThread(
                    () -> {
                        ((ViewGroup) findViewById(R.id.linear_scroll)).addView(button);
                    }
            );
        }
    }
}
