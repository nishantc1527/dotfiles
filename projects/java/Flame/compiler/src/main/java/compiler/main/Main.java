package compiler.main;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import compiler.compilertools.commons.ConsoleColors;
import compiler.compilertools.compilercommons.CompilerError;
import org.jetbrains.annotations.NotNull;
import picocli.CommandLine;

/**
 * The official entry point. TODO Some things that need to be done:
 *
 * <ul>
 *   <li>Make better errors.
 *   <li>Documentation
 *   <li>Remove lombok library (I just use it now for convenience)
 * </ul>
 */
public class Main {
  /** The name of the file to compile. */
  @CommandLine.Option(
      names = {"-f", "--file"},
      required = true,
      description = "The file to compile")
  private String fileName;

  /**
   * Throws a compiler error with a message. It gives the stage in which the error was invoked.
   *
   * @param message The general message of the error.
   * @throws CompilerError Guaranteed.
   */
  private static void error(String message) throws CompilerError {
    throw new CompilerError(
        ConsoleColors.RED_BOLD_BRIGHT + "ERROR: " + ConsoleColors.RESET + message);
  }

  /**
   * The official entry point.
   *
   * @param args Command line arguments. Use {@code -f <file_name>} to specify which file to
   *     compile.
   * @throws CompilerError Or a compiler error occurs.
   * @throws IOException If the file was invalid.
   */
  public static void main(@NotNull String[] args) throws CompilerError, IOException {
    BufferedReader file;
    Main main = new Main();
    new CommandLine(main).parseArgs(args);

    try {
      file = new BufferedReader(new FileReader(new File(main.fileName)));
    } catch (IOException e) {
      error("Please Pass A Valid File");
      return;
    }

    StringBuilder input = new StringBuilder();
    String nextLine;

    while ((nextLine = file.readLine()) != null) {
      input.append(nextLine).append("\n");
    }
  }
}
