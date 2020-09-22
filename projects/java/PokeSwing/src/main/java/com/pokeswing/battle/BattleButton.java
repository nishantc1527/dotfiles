package com.pokeswing.battle;

import javax.swing.*;
import java.awt.*;

public class BattleButton extends JButton {

  public BattleButton(String text, Container container, CardLayout layout) {
    super(text);

    addActionListener(
            (e) -> layout.show(container, "battle panel")
    );
  }

}
