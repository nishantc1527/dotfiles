package com.serverside;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class DatabaseUtils {
  private static File usersFile = new File("Users.txt");
  private static File requestsFile = new File("Request.txt");
  private static final Object requestFileWriteLock = new Object();
  private static final Object userFileWriteLock = new Object();

  public static synchronized NetworkUtils.User handleRegisterRequest(NetworkUtils.User newUser) {
    NetworkUtils.User user = getUserInfo(newUser);
    if (user == null) {
      writeToFile(newUser);
      return newUser;
    } else {
      return user;
    }
  }

  private static synchronized void writeToFile(NetworkUtils.User user) {
    synchronized (userFileWriteLock) {
      PrintWriter writer = null;
      try {
        writer = new PrintWriter(new OutputStreamWriter(new FileOutputStream(usersFile)));
      } catch (FileNotFoundException e) {
        e.printStackTrace();
      }
      writer.println(NetworkUtils.serializeUser(user));
      writer.flush();
      writer.close();
    }
  }

  private static synchronized NetworkUtils.User getUserInfo(NetworkUtils.User user) {
    BufferedReader reader = null;
    try {
      reader = new BufferedReader(new InputStreamReader(new FileInputStream(usersFile)));
    } catch (IOException e) {
      System.out.println("Couldnt read file Users.txt");
      e.printStackTrace();
    }
    String nextLine = NetworkUtils.getSingleLine(reader);
    while (nextLine != null) {
      NetworkUtils.User u = NetworkUtils.deserializeLoginReqeust(nextLine);
      if (u.getUsername().equals(user.getUsername())
          && u.getPassword().equals(user.getPassword())) {
        try {
          reader.close();
        } catch (IOException e) {
          System.out.println("Reader could not close");
          e.printStackTrace();
        }
        return u;
      }

      nextLine = NetworkUtils.getSingleLine(reader);
    }
    return null;
  }

  public static synchronized void handleDeletionRequest(NetworkUtils.RequestRequest deletion) {
    List<NetworkUtils.RequestRequest> list = getRequestList();
    for (int i = 0; i < list.size(); i++) {
      if (list.get(i).getUser().equals(deletion.getUser())) {
        list.remove(i);
        break;
      }
    }

    synchronized (requestFileWriteLock) {
      PrintWriter writer = null;
      try {
        writer = new PrintWriter(new OutputStreamWriter(new FileOutputStream(requestsFile, false)));
      } catch (FileNotFoundException e) {
        e.printStackTrace();
      }

      if (writer != null) {
        for (NetworkUtils.RequestRequest i : list) {
          writer.println(NetworkUtils.serializeRequestRequest(i));
          writer.flush();
        }
        writer.close();
      }
    }
  }

  public static synchronized NetworkUtils.User handleLoginRequest(NetworkUtils.User requests) {
    // TODO: 8/8/20 check the database for whether the login request exists or not
    return getUserInfo(requests);
  }

  public static synchronized void handleRequestRequest(NetworkUtils.RequestRequest request) {
    String jsonString = NetworkUtils.serializeRequestRequest(request);
    PrintWriter pw;

    try {
      pw = new PrintWriter(new OutputStreamWriter(new FileOutputStream(requestsFile, true)));
    } catch (IOException e) {
      e.printStackTrace();
      return;
    }

    pw.println(jsonString);
    pw.flush();
    pw.close();
  }

  public static synchronized List<NetworkUtils.RequestRequest> getRequestList() {
    BufferedReader reader = null;
    try {
      reader = new BufferedReader(new InputStreamReader(new FileInputStream(requestsFile)));
    } catch (FileNotFoundException e) {
      System.out.println("Could not open requests file");
      e.printStackTrace();
    }

    List<NetworkUtils.RequestRequest> res = new ArrayList<>();
    String nextLine = NetworkUtils.getSingleLine(reader);
    while (nextLine != null) {
      res.add(NetworkUtils.deserializeRequestReqeust(nextLine));
      nextLine = NetworkUtils.getSingleLine(reader);
    }

    try {
      reader.close();
    } catch (IOException e) {
      System.out.println("Reader could not close");
      e.printStackTrace();
    }

    return res;
  }
}
