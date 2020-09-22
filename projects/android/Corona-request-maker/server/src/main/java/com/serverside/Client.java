package com.serverside;

import java.io.*;
import java.net.Socket;
import java.util.List;

public class Client {
  private Server server;

  private InputStream in;
  private OutputStream out;

  private BufferedReader reader;
  private PrintWriter writer;

  public Client(Socket socket, Server server) {
    System.out.println("In the client constructor");
    this.server = server;

    try {
      this.in = socket.getInputStream();
      System.out.println("Made the input stream");
    } catch (IOException e) {
      System.out.println("Could not get the input stream from client socket");
      e.printStackTrace();
      return;
    }
    try {
      this.out = socket.getOutputStream();
      System.out.println("Made the output stream");
    } catch (IOException e) {
      System.out.println("Could not get the output stream from client socket");
      e.printStackTrace();
      return;
    }

    reader = new BufferedReader(new InputStreamReader(in));
    writer = new PrintWriter(new OutputStreamWriter(out));

    SocketListener socketListener = new SocketListener();
    Thread socketListenerThread = new Thread(socketListener);
    socketListenerThread.start();
  }

  private class SocketListener implements Runnable {
    public SocketListener() {
      System.out.println("Constructed Socket Listener");
    }

    @Override
    public void run() {
      System.out.println("Running");

      while (true) {
        System.out.println("Getting Line");
        String firstLine = NetworkUtils.getLineAndWait(reader);
        System.out.println("Got Line " + firstLine);
        if (firstLine == null) {
          System.out.println("Got Nothing");
        } else if (firstLine.charAt(0) == '4') {
          String message = NetworkUtils.getLineAndWait(reader);
          System.out.println("Getting a update request request");
          handleDeleteRequest(message);
        } else if (firstLine.charAt(0) == '3') {
          System.out.println("Getting a update request request");
          writeRequestList();
        } else if (firstLine.charAt(0) == '2') {
          String message = NetworkUtils.getLineAndWait(reader);
          System.out.println("Gettings A Request Request");
          handleRequestRequest(message);
        } else if (firstLine.charAt(0) == '1') {
          String message = NetworkUtils.getLineAndWait(reader);
          System.out.println("Gettings A Register Request");
          handleRegisterRequest(message);
        } else if (firstLine.charAt(0) == '0') {
          String message = NetworkUtils.getLineAndWait(reader);
          System.out.println("Gettings A Login Request");
          handleLoginRequest(message);
        }
      }
    }

    void handleDeleteRequest(String message) {
      NetworkUtils.RequestRequest deletion = NetworkUtils.deserializeRequestReqeust(message);
      System.out.println("Handling Deletion of user: " + deletion);
      DatabaseUtils.handleDeletionRequest(deletion);
    }

    void handleRegisterRequest(String message) {
      NetworkUtils.User request = NetworkUtils.deserializeRegisterReqeust(message);
      System.out.println("Handling Register Request");
      NetworkUtils.User user = DatabaseUtils.handleRegisterRequest(request);

      String json = NetworkUtils.serializeUser(user);

      writer.println(json);
      writer.flush();
    }

    void handleLoginRequest(String message) {
      NetworkUtils.User request = NetworkUtils.deserializeLoginReqeust(message);
      System.out.println("Handling Login request");
      NetworkUtils.User user = DatabaseUtils.handleLoginRequest(request);
      writer.println(NetworkUtils.serializeUser(user));
      writer.flush();
    }

    void handleRequestRequest(String message) {
      NetworkUtils.RequestRequest request = NetworkUtils.deserializeRequestReqeust(message);
      System.out.println("Handling A Request Request");
      DatabaseUtils.handleRequestRequest(request);
    }

    void writeRequestList() {
      List<NetworkUtils.RequestRequest> newRequests = DatabaseUtils.getRequestList();
      for (NetworkUtils.RequestRequest i : newRequests) {
        writer.println(NetworkUtils.serializeRequestRequest(i));
      }
      writer.println("**done**");
      writer.flush();
    }
  }
}
