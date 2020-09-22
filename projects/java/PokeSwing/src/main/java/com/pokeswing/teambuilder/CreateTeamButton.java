package com.pokeswing.teambuilder;

import javax.swing.*;
import java.awt.*;

public class CreateTeamButton extends JButton {

  public CreateTeamButton(String text, Container container, CardLayout layout) {
    super(text);

    addActionListener(
            (e) -> layout.show(container, "create team panel")
    );
  }

}
