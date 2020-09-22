package compiler.parser;

import compiler.compilertools.commons.Pair;
import compiler.compilertools.compilercommons.CompilerError;
import compiler.compilertools.compilercommons.lexer.Token;
import compiler.compilertools.compilercommons.lexer.TokenType;
import compiler.compilertools.compilercommons.parser.GrammarSymbol;
import compiler.compilertools.compilercommons.parser.ParserTable;
import compiler.lexer.Lexer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Stack;
import lombok.Data;

/** A TreeNode in the resulting parse tree. */
@Data
public class TreeNode {
  /** If it's a leaf or not */
  private boolean isLeaf;
  /** If it's a leaf, what is the token */
  private Token token;
  /** If it's not a leaf, what is the id of the other grammar symbol */
  private int id;

  private List<TreeNode> children;
  private int currChildIndex;
  private boolean isNil;
  private boolean isOpen;

  /**
   * I can't use {@code @AllArgsConstructor} since I don't want {@code children} to be included.
   *
   * @param isLeaf True if this {@link TreeNode} is a leaf node.
   * @param token If it's a leaf, what is the token.
   * @param id If it's not a leaf, what is the id of the other grammar symbol.
   */
  public TreeNode(boolean isLeaf, Token token, int id) {
    this.isLeaf = isLeaf;
    this.token = token;
    this.id = id;
  }

  /**
   * Check's if the {@link Token} is valid, and updates the tree accordingly.
   *
   * @param nodes The stack that the parser uses to keep track of which {@link TreeNode} that you
   *     are evaluating.
   * @throws CompilerError If the {@link Token} is not valid, meaning that {@link Token} shouldn't
   *     be there.
   */
  public void checkToken(Stack<TreeNode> nodes) throws CompilerError {
    if (!isOpen) {
      isOpen = true;

      children = new ArrayList<>();
      Pair<HashMap<TokenType, List<GrammarSymbol>>, Boolean> pair = ParserTable.parserTable.get(id);
      List<GrammarSymbol> production = pair.first.get(Parser.nextToken.getType());
      boolean orNil = pair.second;

      if (production == null) {
        if (orNil) {
          isNil = true;
          nodes.pop();
        } else {
          Parser.error("Expected Another Token", Parser.nextToken);
        }
      } else {
        for (GrammarSymbol symbol : production) {
          children.add(
              new TreeNode(symbol.isTerminal(), new Token(symbol.getType()), symbol.getId()));
        }
      }
    } else {
      TreeNode child = children.get(currChildIndex);

      if (child.isLeaf) {
        if (child.token.getType().equals(Parser.nextToken.getType())) {
          child.token = Parser.nextToken;
          Parser.nextToken = Lexer.nextToken();
          currChildIndex++;

          if (currChildIndex >= children.size()) {
            nodes.pop();
          }
        } else {
          Parser.error(
              " Expected A "
                  + child.token.getType().toString()
                  + " Got A "
                  + Parser.nextToken.getType(),
              Parser.nextToken);
        }
      } else {
        /* Increment the index now so later when this node gets uncovered
        the index will be just right. Think ahead :) */
        currChildIndex++;
        nodes.push(child);
      }
    }
  }
}
