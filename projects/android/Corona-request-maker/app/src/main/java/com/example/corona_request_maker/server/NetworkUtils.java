package com.example.corona_request_maker.server;

import com.google.gson.Gson;

import java.io.BufferedReader;
import java.io.IOException;

import lombok.AllArgsConstructor;
import lombok.Data;

public class NetworkUtils {
  public static String serializeUser(User request) {
    // First character 0 means login.
    return new Gson().toJson(request);
  }

  public static String serializeRequestRequest(RequestRequest request) {
    // First character 2 means request.
    return new Gson().toJson(request);
  }

  public static User deserializeLoginReqeust(String request) {
    return new Gson().fromJson(request, User.class);
  }

  public static User deserializeRegisterReqeust(String request) {
    return new Gson().fromJson(request, User.class);
  }

  public static RequestRequest deserializeRequestReqeust(String request) {
    return new Gson().fromJson(request, RequestRequest.class);
  }

  public static String getSingleLine(BufferedReader reader) {
    String result = null;
    try {
      result = reader.readLine();
    } catch (IOException e) {
      e.printStackTrace();
      return null;
    }

    return result;
  }

  public static String getLineAndWait(BufferedReader reader) {
    String result = null;
    while (result == null) {
      try {
        result = reader.readLine();

        if (result != null) {
          System.out.println(result);
        }
      } catch (IOException e) {
        e.printStackTrace();
        return null;
      }
    }

    return result;
  }

  @Data
  @AllArgsConstructor
  public static class User {
    private String phoneNumber;
    private String username;
    private String password;
  }

  // wraps a request to register for the first time from a client
  @Data
  @AllArgsConstructor
  public static class RequestRequest {
    private String title, date, time, task;
    private User user;
  }
}
