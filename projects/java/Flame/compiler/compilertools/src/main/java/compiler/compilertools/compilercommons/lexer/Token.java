package compiler.compilertools.compilercommons.lexer;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Token {
  private String lexeme;
  private TokenType type;
  private int line;
  private int col;

  public Token(TokenType type) {
    this.type = type;
  }
}
