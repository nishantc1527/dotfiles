package com.pokeswing.teambuilder;

import javax.swing.*;
import java.awt.*;
import java.util.List;

public class PokemonSelectorPhasePanel extends JPanel {

  private final JPanel selectionAreaPanel;
  private final JPanel buttonsPanel;

  public PokemonSelectorPhasePanel(PokemonSelectorPhase phase, List<String> options) {
    super(new BorderLayout());

    selectionAreaPanel = new SelectionAreaPanel(phase, options);
    add(selectionAreaPanel, BorderLayout.CENTER);

    buttonsPanel = new ButtonsPanel();
    add(buttonsPanel, BorderLayout.SOUTH);
  }

}
