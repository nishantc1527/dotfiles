package com.pokeswing.teambuilder;

import javax.swing.*;
import java.awt.*;

public class CreateTeamPanel extends JPanel {

  private final JButton pokemonSelectorButton1,
          pokemonSelectorButton2,
          pokemonSelectorButton3,
          pokemonSelectorButton4,
          pokemonSelectorButton5,
          pokemonSelectorButton6;

  private UserPokemon pokemon1,
          pokemon2,
          pokemon3,
          pokemon4,
          pokemon5,
          pokemon6;

  public CreateTeamPanel(JPanel mainPanel, CardLayout layout) {
    super(layout);
    setBackground(Color.WHITE);

    pokemonSelectorButton1 = new PokemonSelecterButton(1, mainPanel, layout);
    add(pokemonSelectorButton1);

    pokemonSelectorButton2 = new PokemonSelecterButton(2, mainPanel, layout);
    add(pokemonSelectorButton2);

    pokemonSelectorButton3 = new PokemonSelecterButton(3, mainPanel, layout);
    add(pokemonSelectorButton3);

    pokemonSelectorButton4 = new PokemonSelecterButton(4, mainPanel, layout);
    add(pokemonSelectorButton4);

    pokemonSelectorButton5 = new PokemonSelecterButton(5, mainPanel, layout);
    add(pokemonSelectorButton5);

    pokemonSelectorButton6 = new PokemonSelecterButton(6, mainPanel, layout);
    add(pokemonSelectorButton6);
  }

}
