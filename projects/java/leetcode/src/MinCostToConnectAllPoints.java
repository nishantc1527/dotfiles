import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;

public class MinCostToConnectAllPoints {

  public static void main(String[] args) {
    System.out.println(new MinCostToConnectAllPoints().minCostConnectPoints(new int[][]{{0, 0}, {1, 1}, {1, 0}, {-1, -1}}));
  }

  public int minCostConnectPoints(int[][] points) {
    HashMap<int[], Pair<int[], Integer>> map = new HashMap<>();
    int cost = 0;

    for (int i = 0; i < points.length; i++) {
      int min = Integer.MAX_VALUE;
      int[] other = null;

      for (int j = 0; j < points.length; j++) {
        if (i == j) {
          continue;
        }

        int dist = Math.abs(points[i][0] - points[j][0]) + Math.abs(points[i][1] - points[j][1]);

        if (dist < min && (!map.containsKey(points[j]) || !Arrays.equals(map.get(points[j]).getKey(), points[i]))) {
          min = dist;
          other = points[j];
        }
      }

      if (other != null) {
        map.put(points[i], new Pair<>(other, min));
      }
    }

    for (int i = 0; i < points.length; i++) {
      Pair<int[], Integer> elem = map.get(points[i]);

      if (elem != null && map.get(elem.getKey()) != null && map.get(elem.getKey()).getValue() < elem.getValue() && !hasValue(map, points[i])) {
        map.put(points[i], null);
      }
    }

    for (int i = 0; i < points.length; i++) {
      Pair<int[], Integer> elem = map.get(points[i]);

      if (elem != null) {
        cost += elem.getValue();
      }
    }

    return cost;
  }

  private boolean hasValue(HashMap<int[], Pair<int[], Integer>> map, int[] point) {
    for(Pair<int[], Integer> pair : map.values()) {
      if(Arrays.equals(pair.getKey(), point)) {
        return true;
      }
    }

    return false;
  }

}
