package com.example.corona_request_maker;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

import com.example.corona_request_maker.server.NetworkUtils;

// TODO Check if this works
public class SignUpPage extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup_page);

        findViewById(R.id.login_button).setOnClickListener(
                view -> finish()
        );

        findViewById(R.id.sign_up_button).setOnClickListener(
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

                    TextView phoneView = findViewById(R.id.phone);
                    if (phoneView == null) {
                        return;
                    }
                    String phone = phoneView.getText().toString();

                    NetworkUtils.User user = MainActivity.client.sendRegisterRequest(new NetworkUtils.User(phone, username, password));

                    if(user == null) {
                        usernameView.setText("");
                        passwordView.setText("");
                        phoneView.setText("");
                    } else {
                        MainActivity.user = user;
                        finish();
                    }
                }
        );
    }

}