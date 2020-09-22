package com.example.corona_request_maker.server;

import com.example.corona_request_maker.SeeRequests;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

public class Client {
  private final Socket socket;

  private InputStream in;
  private OutputStream out;

  private BufferedReader reader;
  private PrintWriter writer;

  private final Object writerLock;
  private final Object readerLock;

  public Client(Socket socket) {
    this.socket = socket;
    readerLock = new Object();
    writerLock = new Object();

    try {
      this.in = socket.getInputStream();
    } catch (IOException e) {
      System.out.println("Could not get the input stream from client socket");
      e.printStackTrace();
      return;
    }
    try {
      this.out = socket.getOutputStream();
    } catch (IOException e) {
      System.out.println("Could not get the output stream from client socket");
      e.printStackTrace();
      return;
    }

    reader = new BufferedReader(new InputStreamReader(in));
    writer = new PrintWriter(new OutputStreamWriter(out));
  }

  public NetworkUtils.User sendRegisterRequest(NetworkUtils.User request) {
    final Object retLock = new Object();
    NetworkUtils.User[] res = new NetworkUtils.User[1];
    res[0] = null;
    new Thread(
            () -> {
              synchronized (writerLock) {
                synchronized (readerLock) {
                  synchronized (retLock) {
                    System.out.println("Sending Register Request");
                    writer.println("1");
                    writer.flush();
                    writer.println(NetworkUtils.serializeUser(request));
                    writer.flush();
                    System.out.println("Sent Register Request");

                    String next = NetworkUtils.getLineAndWait(reader);
                    res[0] = NetworkUtils.deserializeLoginReqeust(next);
                  }
                }
              }
            }
    ).start();
    boolean shouldRet = false;
    while (!shouldRet) {
      synchronized (retLock) {
        if (res[0] != null) {
          shouldRet = true;
        }
      }
    }

    return res[0];
  }

  public NetworkUtils.User sendLoginRequest(NetworkUtils.User request) {
    final Object retLock = new Object();
    NetworkUtils.User[] res = new NetworkUtils.User[1];
    res[0] = null;
    new Thread(() -> {
    synchronized (writerLock) {
      synchronized (readerLock) {
        synchronized (retLock) {
          System.out.println("Sending login request");
          writer.println("0");
          writer.println(NetworkUtils.serializeUser(request));
          System.out.println("Sent login request");
          writer.flush();

          String next = NetworkUtils.getLineAndWait(reader);
          res[0] = NetworkUtils.deserializeLoginReqeust(next);
        }
      }
    }}).start();

    boolean shouldRet = false;
    while (!shouldRet) {
      synchronized (retLock) {
        if (res[0] != null) {
          shouldRet = true;
        }
      }
    }

    return res[0];
  }

  public void sendRequestRequest(NetworkUtils.RequestRequest request) {
    new Thread(() -> {
      synchronized (writerLock) {
        writer.println("2");
        writer.println(NetworkUtils.serializeRequestRequest(request));
        writer.flush();
      }
    }).start();
  }

  public void sendDeleteRequestRequest(NetworkUtils.RequestRequest request) {
    new Thread(() -> {
      synchronized (writerLock) {
        writer.println("4");
        writer.println(NetworkUtils.serializeRequestRequest(request));
        writer.flush();
      }
    }).start();
  }

  public void listenForRequestRequests(SeeRequests page) {
    RequestListener listener = new RequestListener(page);
    Thread requestListenerThread = new Thread(listener);
    requestListenerThread.start();
  }

  private class RequestListener implements Runnable {
    private SeeRequests page;

    public RequestListener(SeeRequests page) {
      this.page = page;
    }

    @Override
    public void run() {
      synchronized (writerLock) {
        writer.println("3");
        writer.flush();
      }

      List<NetworkUtils.RequestRequest> list = new ArrayList<>();
      synchronized (readerLock) {
        String nextLine = NetworkUtils.getLineAndWait(reader);
        while (nextLine == null || !nextLine.equals("**done**")) {
          list.add(NetworkUtils.deserializeRequestReqeust(nextLine));
          nextLine = NetworkUtils.getLineAndWait(reader);
        }
      }
      page.updateScrollRequests(list);
    }

  }
}
