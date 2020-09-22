package com.example.corona_request_maker;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import androidx.core.app.NotificationCompat;

import com.example.corona_request_maker.server.Client;
import com.example.corona_request_maker.server.NetworkUtils;

import java.io.IOException;
import java.net.Socket;

public class MainActivity extends Activity {
    public static Client client;
    public static NetworkUtils.User user;

    public static int portNum;
    public static String serverIpAddr;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        System.out.println("connecting");
        portNum = 8080; // The port number
        serverIpAddr = "192.168.1.18"; // My ip address
        new Thread(() -> {
            try {
                Socket s = new Socket(serverIpAddr, portNum);
                client = new Client(s);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }).start();
        System.out.println("connected");

        findViewById(R.id.view_requests).setOnClickListener(
                view -> {
                    Intent intent = new Intent(MainActivity.this, SeeRequests.class);
                    startActivity(intent);
                }
        );

        findViewById(R.id.request_button).setOnClickListener((view) ->{
            Intent intent = new Intent(this, RequestPage.class);
            startActivity(intent);
        });

        Intent intent = new Intent(this, LoginPage.class);
        startActivity(intent);
    }

    private void sendNotification(Request r) {
        String message = r.getTitle() + "   " + r.getDate() + "   " + r.getTime();
        NotificationCompat.Builder builder = new NotificationCompat.Builder(this, "1")
                .setSmallIcon(R.drawable.ic_launcher_foreground)
                .setContentTitle("Request Accepted")
                .setContentText(message)
                .setPriority(NotificationCompat.PRIORITY_DEFAULT);
    }
}