package compiler.lexer;

import static org.junit.Assert.assertEquals;

import compiler.compilertools.compilercommons.CompilerError;
import compiler.compilertools.compilercommons.lexer.Token;
import compiler.compilertools.compilercommons.lexer.TokenType;
import org.junit.Test;

public class TestLexer {

  @Test
  public void testLexer() throws CompilerError {
    Lexer.init("# comment\n" + "program\n" + "uses\n" + "a b123 _c\n");

    assertEquals(new Token("# comment\n", TokenType.COMMENT, 1, 1), Lexer.nextToken());
    assertEquals(new Token("program", TokenType.PROGRAM, 2, 1), Lexer.nextToken());
    assertEquals(new Token("\n", TokenType.NEW_LINE, 2, 8), Lexer.nextToken());
    assertEquals(new Token("uses", TokenType.USES, 3, 1), Lexer.nextToken());
    assertEquals(new Token("\n", TokenType.NEW_LINE, 3, 5), Lexer.nextToken());
    assertEquals(new Token("a", TokenType.ID, 4, 1), Lexer.nextToken());
    assertEquals(new Token(" ", TokenType.BLANK, 4, 2), Lexer.nextToken());
    assertEquals(new Token("b123", TokenType.ID, 4, 3), Lexer.nextToken());
    assertEquals(new Token(" ", TokenType.BLANK, 4, 7), Lexer.nextToken());
    assertEquals(new Token("_c", TokenType.ID, 4, 8), Lexer.nextToken());
    assertEquals(new Token("\n", TokenType.NEW_LINE, 4, 10), Lexer.nextToken());
    assertEquals(new Token("", TokenType.EOF, 5, 1), Lexer.nextToken());
  }

  @Test(expected = CompilerError.class)
  public void testErrLexer() throws CompilerError {
    Lexer.init("?#");

    Lexer.nextToken();
  }

  // TODO Add more error token testing. I have faith that it works, so I'll do it later.

}
