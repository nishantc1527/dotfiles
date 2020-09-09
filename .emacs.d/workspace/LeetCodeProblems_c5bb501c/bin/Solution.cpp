#include <vector>
#include <map>

#include "../Nodes.h"

class Solution {
public:
  TreeNode* buildTree(std::vector<int>& inorder, std::vector<int>& postorder) {
    std::map<int, int> in_ind, post_ind;
    for (int i = 0; i < inorder.size(); i++) {
      in_ind[inorder[i]] = i;
      post_ind[postorder[i]] = i;
    }

    TreeNode* root = new TreeNode(postorder.back());
    if (inorder.size() == 1) return root;
    int i = in_ind[postorder.back()];

    return root;
  }
};
