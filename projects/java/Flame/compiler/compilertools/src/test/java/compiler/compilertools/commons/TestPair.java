package compiler.compilertools.commons;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

public class TestPair {

  private Pair<Integer, Integer> pair;

  @Before
  public void setup() {
    pair = new Pair<>(1, 2);
  }

  @Test
  public void testDefaultConstructor() {
    pair = new Pair<>();
    assertNull(pair.getFirst());
    assertNull(pair.getSecond());
  }

  @Test
  public void testConstructor() {
    assertEquals(pair.getFirst(), Integer.valueOf(1));
    assertEquals(pair.getSecond(), Integer.valueOf(2));
  }

  @Test
  public void testEquals() {
    Pair<Integer, Integer> other = new Pair<>(1, 2);
    assertEquals(pair, other);
    other.setFirst(2);
    assertNotEquals(pair, other);
  }

  @Test
  public void testBuilder() {
    assertEquals(Pair.builder().first(1).second(2).build(), pair);
  }
}
