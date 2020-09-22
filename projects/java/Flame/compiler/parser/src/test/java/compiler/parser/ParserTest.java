package compiler.parser;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

import compiler.compilertools.compilercommons.CompilerError;
import compiler.compilertools.compilercommons.lexer.TokenType;
import compiler.lexer.Lexer;
import org.junit.Test;

public class ParserTest {

  @Test
  public void testParser() throws CompilerError {
    Lexer.init("program {" + "\n" + "uses {" + "\n" + "}" + "}");
    TreeNode root = Parser.generateTree();

    assertFalse(root.isLeaf());
    assertEquals(0, root.getId());
    assertEquals(TokenType.PROGRAM, root.getChildren().get(0).getToken().getType());
  }
}
