package compiler.compilertools.compilercommons.parser;

import compiler.compilertools.commons.Pair;
import compiler.compilertools.compilercommons.lexer.TokenType;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class ParserTable {
  public static final ArrayList<Pair<HashMap<TokenType, List<GrammarSymbol>>, Boolean>>
      parserTable =
          new ArrayList<Pair<HashMap<TokenType, List<GrammarSymbol>>, Boolean>>() {
            {
              add(
                  /* program */
                  new Pair<>(
                      new HashMap<TokenType, List<GrammarSymbol>>() {
                        {
                          put(
                              TokenType.PROGRAM,
                              Arrays.asList(
                                  new GrammarSymbol(true, TokenType.PROGRAM, 0),
                                  new GrammarSymbol(true, TokenType.BLANK, 0),
                                  new GrammarSymbol(true, TokenType.LEFT_CURLY, 0),
                                  new GrammarSymbol(true, TokenType.NEW_LINE, 0),
                                  new GrammarSymbol(false, null, 1),
                                  new GrammarSymbol(false, null, 3),
                                  new GrammarSymbol(true, TokenType.RIGHT_CURLY, 0)));
                        }
                      },
                      false));

              add(
                  /* configurations */ new Pair<>(
                      new HashMap<TokenType, List<GrammarSymbol>>() {
                        {
                          put(
                              TokenType.USES,
                              Arrays.asList(
                                  new GrammarSymbol(true, TokenType.USES, 0),
                                  new GrammarSymbol(true, TokenType.BLANK, 0),
                                  new GrammarSymbol(true, TokenType.LEFT_CURLY, 0),
                                  new GrammarSymbol(true, TokenType.NEW_LINE, 0),
                                  new GrammarSymbol(false, null, 2),
                                  new GrammarSymbol(true, TokenType.RIGHT_CURLY, 0)));
                        }
                      },
                      true));

              add(
                  /* libraries */ new Pair<>(
                      new HashMap<TokenType, List<GrammarSymbol>>() {
                        {
                          put(
                              TokenType.ID,
                              Arrays.asList(
                                  new GrammarSymbol(false, null, 7),
                                  new GrammarSymbol(true, TokenType.NEW_LINE, 0),
                                  new GrammarSymbol(false, null, 7)));
                        }
                      },
                      true));

              add(
                  /* statements */ new Pair<>(
                      new HashMap<TokenType, List<GrammarSymbol>>() {
                        {
                          put(
                              TokenType.ID,
                              Arrays.asList(
                                  new GrammarSymbol(false, null, 4),
                                  new GrammarSymbol(true, TokenType.NEW_LINE, 0),
                                  new GrammarSymbol(false, null, 4)));
                        }
                      },
                      true));

              add(
                  /* statement */ new Pair<>(
                      new HashMap<TokenType, List<GrammarSymbol>>() {
                        {
                          put(
                              TokenType.ID,
                              Arrays.asList(
                                  new GrammarSymbol(true, TokenType.ID, 0),
                                  new GrammarSymbol(true, TokenType.LEFT, 0),
                                  new GrammarSymbol(false, null, 5),
                                  new GrammarSymbol(true, TokenType.RIGHT, 0)));
                        }
                      },
                      false));

              add(
                  /* parameters */ new Pair<>(
                      new HashMap<TokenType, List<GrammarSymbol>>() {
                        {
                          put(
                              TokenType.ID,
                              Arrays.asList(
                                  new GrammarSymbol(false, null, 6),
                                  new GrammarSymbol(true, TokenType.COMMA, 0),
                                  new GrammarSymbol(false, null, 6)));
                        }
                      },
                      true));

              add(
                  /* expr */ new Pair<>(
                      new HashMap<TokenType, List<GrammarSymbol>>() {
                        {
                          put(
                              TokenType.ID,
                              Arrays.asList(new GrammarSymbol(true, TokenType.ID, 0)));
                        }
                      },
                      false));

              add(
                  /* library */ new Pair<>(
                      new HashMap<TokenType, List<GrammarSymbol>>() {
                        {
                          put(
                              TokenType.ID,
                              Arrays.asList(new GrammarSymbol(true, TokenType.ID, 0)));
                        }
                      },
                      false));
            }
          };
}
