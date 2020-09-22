package compiler.lexer;

import compiler.compilertools.commons.ConsoleColors;
import compiler.compilertools.compilercommons.CompilerError;
import compiler.compilertools.compilercommons.lexer.StateMachine;
import compiler.compilertools.compilercommons.lexer.Token;
import compiler.compilertools.compilercommons.lexer.TokenType;
import java.util.Map;
import lombok.Data;

/**
 * The lexer, which contains the {@link #nextToken()} method which returns the next {@link Token} in
 * the input file. Before you can use the lexer, you have to call the {@link #init(String)} and
 * passing the input string with {@code \n} in between each line.
 */
@Data
public class Lexer {

  /** The current line in the input string. */
  private static int line;

  /** The current column in the input string. */
  private static int col;

  /** The current position in the input string, 0-indexed. */
  private static int pos;

  /** The whole input string. */
  private static String input;

  /**
   * Throws a {@link CompilerError}.
   *
   * @param message The message of the error.
   * @throws CompilerError Guaranteed.
   */
  private static void error(String message) throws CompilerError {
    throw new CompilerError(
        ConsoleColors.RED_BOLD_BRIGHT
            + "LEXER ERROR: "
            + ConsoleColors.RESET
            + message
            + " At Line "
            + line
            + " And Column "
            + col);
  }

  /**
   * Initializes the lexer.
   *
   * @param input The input string of the file.
   */
  public static void init(String input) {
    pos = 0;
    col = line = 1;
    Lexer.input = input;
  }

  /**
   * Gives the next {@link Token} from the input string.
   *
   * @return the next {@link Token}.
   * @throws CompilerError If a lexical error occurs.
   */
  public static Token nextToken() throws CompilerError {
    if (pos >= input.length()) {
      return new Token("", TokenType.EOF, line, col);
    }

    int state = 0;

    int posCopy = pos; /* Copy the positions to save the initial locations of the tokens */
    int lineCopy = line;
    int colCopy = col;

    StringBuilder nextLexme = new StringBuilder();

    while (true) {
      if (posCopy >= input.length()) {
        break;
      }

      char next = input.charAt(posCopy);
      Map<Character, Integer> map = StateMachine.stateMachine.get(state);
      Integer nextState = map.get(next);

      if (nextState == null) {
        break;
      }

      state = nextState;

      if (next == '\n') {
        colCopy = 1;
        lineCopy++;
      } else {
        colCopy++;
      }

      posCopy++;
      nextLexme.append(next);
    }

    if (StateMachine.acceptingStates.contains(state)) {
      String lexme = nextLexme.toString();
      Token ans = generateEntry(state, lexme);

      pos = posCopy;
      line = lineCopy;
      col = colCopy;

      return ans;
    } else {
      error("Unexpected Token: " + nextLexme);
    }

    return null;
  }

  /**
   * Based on the state and the lexme, it returns the correct {@link Token}.
   *
   * @param state The state in the state machine.
   * @param lexme The current lexme, used to find if and identifier is actually a keyword.
   * @return The resulting {@link Token}.
   * @throws CompilerError If for some reason the state and lexme cannot determine the {@link
   *     Token}.
   */
  public static Token generateEntry(int state, String lexme) throws CompilerError {
    switch (state) {
      case 1:
      case 2:
        if (lexme.equals("program")) {
          return new Token(lexme, TokenType.PROGRAM, line, col);
        } else if (lexme.equals("uses")) {
          return new Token(lexme, TokenType.USES, line, col);
        } else {
          return new Token(lexme, TokenType.ID, line, col);
        }
      case 3:
        return new Token(lexme, TokenType.LEFT_CURLY, line, col);
      case 4:
        return new Token(lexme, TokenType.RIGHT_CURLY, line, col);
      case 5:
        return new Token(lexme, TokenType.LEFT, line, col);
      case 6:
        return new Token(lexme, TokenType.RIGHT, line, col);
      case 8:
        return new Token(lexme, TokenType.COMMENT, line, col);
      case 9:
        return new Token(lexme, TokenType.BLANK, line, col);
      case 10:
        return new Token(lexme, TokenType.NEW_LINE, line, col);
      case 11:
        return new Token(lexme, TokenType.COMMA, line, col);
      default:
        throw new CompilerError("Unkown Error");
    }
  }
}
