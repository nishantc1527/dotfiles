package com.pokeswing.teambuilder;

import javax.swing.*;
import java.awt.*;

public class ButtonsPanel extends JPanel {

  private final JButton backButton, nextButton;

  public ButtonsPanel() {
    super(new BorderLayout());
    setBackground(Color.WHITE);

    backButton = new BackButton();
    add(backButton, BorderLayout.WEST);

    nextButton = new NextButton();
    add(nextButton, BorderLayout.EAST);
  }

}
