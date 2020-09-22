package com.pokeswing;

import javax.swing.*;
import java.awt.*;

public class Main extends JFrame {

  private static Main main;

  private final JPanel mainPanel;

  private Main() {
    setBounds(500, 500, 500, 500);
    setDefaultCloseOperation(EXIT_ON_CLOSE);

    mainPanel = new MainPanel(new CardLayout());
    add(mainPanel);

    setVisible(true);
  }

  public static void main(String[] args) {
    main = new Main();
  }
}
