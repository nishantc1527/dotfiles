package compiler.main;

import compiler.compilertools.compilercommons.CompilerError;
import java.io.IOException;
import org.junit.Test;
import picocli.CommandLine;

public class MainTest {

  @Test(expected = CommandLine.MissingParameterException.class)
  public void testNoFile() throws CompilerError, IOException {
    Main.main(new String[0]);
  }

  @Test(expected = CompilerError.class)
  public void testBadFile() throws CompilerError, IOException {
    Main.main(new String[] {"-f", "a.flm"});
  }

  @Test
  public void testGoodFile() throws CompilerError, IOException {
    Main.main(new String[] {"-f", "testfiles/test.flm"});
  }
}
