class UnionFind {

  public int[] parents;

  public UnionFind(int n) {
    parents = new int[n];

    for (int i = 0; i < parents.length; i++) {
      parents[i] = i;
    }
  }

  public int find(int i) {
    if(i != parents[i]) {
      parents[i] = find(parents[i]);
    }

    return parents[i];
  }

  public void unite(int a, int b) {
    parents[find(a)] = find(b);
  }

}
