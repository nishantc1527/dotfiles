package com.example.corona_request_maker;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

import com.example.corona_request_maker.server.NetworkUtils;

// TODO Check if this works
public class LoginPage extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login_page);

        findViewById(R.id.sign_up_button).setOnClickListener(
                view -> {
                    Intent intent = new Intent(LoginPage.this, SignUpPage.class);
                    startActivity(intent);
                }
        );

        findViewById(R.id.login_button).setOnClickListener(
                view -> {
                    TextView usernameView = findViewById(R.id.username);
                    if (usernameView == null) {
                        return;
                    }
                    String username = usernameView.getText().toString();

                    TextView passwordView = findViewById(R.id.password);
                    if (passwordView == null) {
                        return;
                    }
                    String password = passwordView.getText().toString();

                    NetworkUtils.User user = MainActivity.client.sendLoginRequest(new NetworkUtils.User(null, username, password));

                    if(user == null) {
                        usernameView.setText("");
                        passwordView.setText("");
                    } else {
                        MainActivity.user = user;
                        finish();
                    }
                }
        );
    }

    @Override
    protected void onResume() {
        super.onResume();

        if (MainActivity.user != null) {
            finish();
        }
    }
}