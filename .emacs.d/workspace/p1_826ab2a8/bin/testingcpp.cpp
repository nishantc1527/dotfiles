#include <algorithm>
#include <type_traits>
#include <vector>
#include <iostream>

int main(int argc, char *argv[]) {
  std::cout << "Hello there" << '\n';
  std::cout << "Hey" << '\n';

  std::vector<int> my_vec;
  std::sort(my_vec.begin(), my_vec.end());
}
