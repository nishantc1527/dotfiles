package com.serverside;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

public class Server {
  private ServerSocket serverSocket;
  public static final int portNum;
  private List<Client> clients;
  private final Object clientListLock;
  private final Thread clientListenerThread;
  private final NewClientConnectionListener clientListener;

  static {
    portNum = 8080; // The port number
  }

  public Server() {
    clientListLock = new Object();
    clients = new ArrayList<>();
    try {
      serverSocket = new ServerSocket(portNum);
      System.out.println("server socket has started");
    } catch (IOException e) {
      System.err.println("Could not create the server socket on port " + portNum);
      e.printStackTrace();
    }
    clientListener = new NewClientConnectionListener();
    clientListenerThread = new Thread(clientListener);
    clientListenerThread.start();
  }

  private class NewClientConnectionListener implements Runnable {
    @Override
    public void run() {
      while (true) {
        Socket socket = null;
        try {
          socket = serverSocket.accept();
        } catch (IOException e) {
          System.out.println("Socket could not be connected");
          e.printStackTrace();
        } catch (NullPointerException e) {
          System.err.println("Hello there");
          e.printStackTrace();
        }
        if (socket != null) {
          System.out.println("new connection made with client");
          synchronized (clientListLock) {
            System.out.println("Creating client object");
            Client newClient = new Client(socket, Server.this);
            clients.add(newClient);
          }
        }
      }
    }
  }
}
