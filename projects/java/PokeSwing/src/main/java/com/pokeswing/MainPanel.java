package com.pokeswing;

import com.pokeswing.battle.BattleButton;
import com.pokeswing.battle.BattlePanel;
import com.pokeswing.teambuilder.CreateTeamButton;
import com.pokeswing.teambuilder.CreateTeamPanel;

import javax.swing.*;
import java.awt.*;

public class MainPanel extends JPanel {

  private final JPanel homePanel, createTeamPanel, battlePanel;
  private final JButton createTeamButton, battleButton;

  public MainPanel(CardLayout layout) {
    super(layout);

    homePanel = new HomePanel();
    add("home panel", homePanel);

    createTeamPanel = new CreateTeamPanel(this, new CardLayout());
    add("create team panel", createTeamPanel);

    battlePanel = new BattlePanel();
    add("battle panel", battlePanel);

    createTeamButton = new CreateTeamButton("Create Team", this, layout);
    homePanel.add(createTeamButton);

    battleButton = new BattleButton("Battle", this, layout);
    homePanel.add(battleButton);
  }
}
