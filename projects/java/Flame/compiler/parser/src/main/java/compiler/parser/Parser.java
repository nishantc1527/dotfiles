package compiler.parser;

import compiler.compilertools.commons.ConsoleColors;
import compiler.compilertools.compilercommons.CompilerError;
import compiler.compilertools.compilercommons.lexer.Token;
import compiler.compilertools.compilercommons.lexer.TokenType;
import compiler.lexer.Lexer;
import java.util.Objects;
import java.util.Stack;

/**
 * The parser, which contains the {@link #generateTree()} method. That method returns the root
 * {@link TreeNode} of the parse tree.
 */
public class Parser {

  /** The next {@link Token} to evaluate. */
  public static Token nextToken;

  /**
   * Throws a compiler error, specifying the error occurred during the parser stage.
   *
   * @param message The message of the error.
   * @param nextToken Used for getting the line and column the error occured at.
   * @throws CompilerError Guaranteed.
   */
  public static void error(String message, Token nextToken) throws CompilerError {
    throw new CompilerError(
        ConsoleColors.RED_BOLD_BRIGHT
            + "PARSER ERROR: "
            + ConsoleColors.RESET
            + message
            + " At Line "
            + nextToken.getLine()
            + " And Column "
            + nextToken.getCol());
  }

  /**
   * The method that generates the parse tree.
   *
   * @return The root {@link TreeNode} of the tree.
   * @throws CompilerError If a parsing error occurs.
   */
  public static TreeNode generateTree() throws CompilerError {
    TreeNode ans = new TreeNode(false, null, 0);

    Stack<TreeNode> nodes = new Stack<>();
    nodes.add(ans);

    nextToken = Lexer.nextToken();

    while (Objects.requireNonNull(nextToken).getType() != TokenType.EOF) {
      nodes.peek().checkToken(nodes);
    }

    return ans;
  }
}
