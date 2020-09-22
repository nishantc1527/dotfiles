import java.util.HashSet;
import java.util.Set;

/**
 * FriendCircles
 */
public class FriendCircles {

  public static void main(String[] args) {
    System.out.println(new FriendCircles()
        .findCircleNum(new int[][] { { 1, 0, 0, 1 }, { 0, 1, 1, 0 }, { 0, 1, 1, 1 }, { 1, 0, 1, 1 } }));
  }

  public int findCircleNum(int[][] M) {
    UnionFind unionFind = new UnionFind(M.length);

    for (int i = 0; i < M.length; i++) {
      for (int j = 0; j < M[i].length; j++) {
        if (M[i][j] == 1) {
          unionFind.unite(i, j);
        }
      }
    }

    Set<Integer> set = new HashSet<>();
    int ans = 0;

    for (int i = 0; i < M.length; i++) {
      int curr = unionFind.find(i);

      if (set.contains(curr)) {
        continue;
      }

      ans++;
      set.add(curr);
    }

    return ans;
  }
}
