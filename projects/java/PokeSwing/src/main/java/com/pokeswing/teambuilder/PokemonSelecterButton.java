package com.pokeswing.teambuilder;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;
import java.util.Arrays;

public class PokemonSelecterButton extends JButton {

  private final JPanel nameSelector, nicknameSelector, move1Selector, move2Selector, move3Selector, move4Selector, abilitySelector;

  public PokemonSelecterButton(int num, JPanel mainPanel, CardLayout layout) {
    super("Pokemon " + num);

    nameSelector = new PokemonSelectorPhasePanel(PokemonSelectorPhase.NAME, Arrays.asList("pokemon1", "pokemon2", "pokemon3"));
    mainPanel.add("name selector phase " + num, nameSelector);

    nicknameSelector = new PokemonSelectorPhasePanel(PokemonSelectorPhase.NICKNAME, new ArrayList<>());
    mainPanel.add("nickname selector phase " + num, nicknameSelector);

    move1Selector = new PokemonSelectorPhasePanel(PokemonSelectorPhase.MOVE1, Arrays.asList("thing move", "move thingy", "super thingy move"));
    mainPanel.add("move 1 selector phase " + num, move1Selector);

    move2Selector = new PokemonSelectorPhasePanel(PokemonSelectorPhase.MOVE2, Arrays.asList("thing move", "move thingy", "super thingy move"));
    mainPanel.add("move 2 selector phase " + num, move2Selector);

    move3Selector = new PokemonSelectorPhasePanel(PokemonSelectorPhase.MOVE3, Arrays.asList("thing move", "move thingy", "super thingy move"));
    mainPanel.add("move 3 selector phase " + num, move3Selector);

    move4Selector = new PokemonSelectorPhasePanel(PokemonSelectorPhase.MOVE4, Arrays.asList("thing move", "move thingy", "super thingy move"));
    mainPanel.add("move 4 selector phase " + num, move4Selector);

    abilitySelector = new PokemonSelectorPhasePanel(PokemonSelectorPhase.ABILITY, Arrays.asList("ability", "good ability"));
    mainPanel.add("ability selector phase " + num, abilitySelector);
  }

}
