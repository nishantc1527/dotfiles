package compiler.compilertools.compilercommons.lexer;

public enum TokenType {
  /* IDENTIFIERS */
  ID /* Variable/Method Names */, /* KEYWORDS */
  PROGRAM /* program */,
  USES /* uses */, /* WHITESPACE */
  BLANK /* Space, \t */,
  NEW_LINE /* \n */, /* PARENTHESES */
  LEFT /* ( */,
  RIGHT /* ) */,
  LEFT_CURLY /* { */,
  RIGHT_CURLY /* } */, /* OTHER */
  COMMA /* , */,
  COMMENT /* # ... */,
  EOF /* End Of File */
}
