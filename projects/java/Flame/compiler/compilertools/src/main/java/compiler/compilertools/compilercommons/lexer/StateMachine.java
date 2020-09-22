package compiler.compilertools.compilercommons.lexer;

import java.util.*;

public class StateMachine {
  public static final List<Map<Character, Integer>> stateMachine;
  public static Set<Integer> acceptingStates;

  static {
    stateMachine = new ArrayList<>();
    acceptingStates = new HashSet<>();
    initStateMachine();
  }

  private static void initStateMachine() {
    stateMachine.add(
        /* State 0 */ new HashMap<Character, Integer>() {
          {
            for (char c = 'a'; c <= 'z'; c++) {
              put(c, 1);
            }
            for (char c = 'A'; c <= 'Z'; c++) {
              put(c, 1);
            }
            put('_', 1);
            put('{', 3);
            put('}', 4);
            put('(', 5);
            put(')', 6);
            put('#', 7);
            put(' ', 9);
            put('\t', 9);
            put('\n', 10);
            put(',', 11);
          }
        });
    stateMachine.add(
        /* State 1 */ new HashMap<Character, Integer>() {
          {
            for (char c = 'a'; c <= 'z'; c++) {
              put(c, 2);
            }
            for (char c = 'A'; c <= 'Z'; c++) {
              put(c, 2);
            }
            for (char c = '0'; c <= '9'; c++) {
              put(c, 2);
            }
            put('_', 2);
          }
        });
    stateMachine.add(
        /* State 2 */ new HashMap<Character, Integer>() {
          {
            for (char c = 'a'; c <= 'z'; c++) {
              put(c, 2);
            }
            for (char c = 'A'; c <= 'Z'; c++) {
              put(c, 2);
            }
            for (char c = '0'; c <= '9'; c++) {
              put(c, 2);
            }
            put('_', 2);
          }
        });
    stateMachine.add(/* State 3 */ new HashMap<Character, Integer>() {});
    stateMachine.add(/* State 4 */ new HashMap<Character, Integer>() {});
    stateMachine.add(/* State 5 */ new HashMap<Character, Integer>() {});
    stateMachine.add(/* State 6 */ new HashMap<Character, Integer>() {});
    stateMachine.add(
        /* State 7 */ new HashMap<Character, Integer>() {
          {
            for (char c = 0; c <= 255; c++) {
              if (c == '\n') {
                continue;
              }
              put(c, 7);
            }
            put('\n', 8);
          }
        });
    stateMachine.add(/* State 8 */ new HashMap<Character, Integer>() {});
    stateMachine.add(
        /* State 9 */ new HashMap<Character, Integer>() {
          {
            put(' ', 9);
            put('\t', 9);
          }
        });
    stateMachine.add(
        /* State 10 */ new HashMap<Character, Integer>() {
          {
            put('\n', 10);
          }
        });
    stateMachine.add(/* State 11 */ new HashMap<Character, Integer>() {});
    acceptingStates =
        new HashSet<Integer>() {
          {
            add(1);
            add(2);
            add(3);
            add(4);
            add(5);
            add(6);
            add(8);
            add(9);
            add(10);
            add(11);
          }
        };
  }
}
