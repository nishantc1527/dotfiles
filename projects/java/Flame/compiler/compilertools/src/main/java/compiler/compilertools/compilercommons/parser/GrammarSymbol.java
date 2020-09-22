package compiler.compilertools.compilercommons.parser;

import compiler.compilertools.compilercommons.lexer.TokenType;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GrammarSymbol {
  boolean terminal;
  /** If it's a terminal, what is the token type. */
  private TokenType type;
  /** If it's a non-terminal, what is the id */
  private int id;
}
