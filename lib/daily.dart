import 'dart:collection';
import 'dart:math';
import 'dart:math';

class Daily {
  // https://leetcode-cn.com/problems/xor-operation-in-an-array/

  //    给你两个整数，n 和 start 。
  //    数组 nums 定义为：nums[i] = start + 2*i（下标从 0 开始）且 n == nums.length 。
  //    请返回 nums 中所有元素按位异或（XOR）后得到的结果。

  int xorOperation(int n, int start) {
    int ans = start;
    for (int i = 0; i < n; i++) {
      ans = ans ^ start + 2 * i;
    }
    return ans;
  }

  int nthUglyNumber(int n) {
    int a = 0;
    int b = 0;
    int c = 0;
    var dp = List.filled(n, 0);
    dp[0] = 1;
    int i = 1;
    while (i < n) {
      int n2 = dp[a] * 2, n3 = dp[b] * 3, n5 = dp[c] * 5;
      dp[i] = min(min(n2, n3), n5);
      if (dp[i] == n2) a++;
      if (dp[i] == n3) b++;
      if (dp[i] == n5) c++;
      i++;
    }

    return dp[n - 1];
  }

  // https://leetcode-cn.com/problems/longest-common-subsequence/

  int maxUncrossedLines(List<int> num1, List<int> num2) {
    int n = num1.length;
    int m = num2.length;
    List<List<int>> f = List.generate(n, (index) => List.filled(m, 0));
    for (int i = 1; i < n; i++) {
      for (int j = 1; j < m; j++) {
        f[i][j] = max(f[i][j - 1], f[i - 1][j]);
        if (num1[i] == num2[j]) f[i][j] = f[i - 1][j - 1] + 1;
      }
    }
    return f[n - 1][m - 1];
  }

  // https://leetcode-cn.com/problems/chalkboard-xor-game/
  bool xorGame(List<int> array) {
    if (array.length % 2 == 0)
      return true;
    else {
      int sum = 0;
      for (int num in array) {
        sum ^= num;
      }
      return sum == 0;
    }
  }

  // https://leetcode-cn.com/problems/reverse-substrings-between-each-pair-of-parentheses/

  String reverseParentheses(String s) {
    var len = s.length;
    var pair = List.filled(len, 0);
    var stack = DoubleLinkedQueue<int>();
    for (int i = 0; i < len; i++) {
      if (s[i] == '(') {
        stack.addFirst(i);
      } else if (s[i] == ')') {
        var j = stack.removeFirst();
        pair[i] = j;
        pair[j] = i;
      }
    }

    var sb = StringBuffer();
    var index = 0, step = 1;
    while (index < len) {
      if (s[index] == '(' || s[index] == ')') {
        index = pair[index];
        step = -step;
      } else {
        sb.write(s[index]);
      }
      index += step;
    }
    return sb.toString();
  }

  // https://leetcode-cn.com/problems/hamming-distance/
  // use xor
  int hammingDistance(int x, int y) {
    int s = x ^ y, ret = 0;
    // while(s != 0){
    //   /// first is 0 -> 0 else 1
    //   ret += s & 1;
    //   s >>= 1;
    // }
    while (s != 0) {
      s &= s - 1;
      ret++;
    }
    return ret;
  }

  // https://leetcode-cn.com/problems/total-hamming-distance/
  // 若长度为 nn 的数组 \textit{nums}nums 的所有元素二进制的第 ii 位共有 cc 个 11，n-cn−c 个 00，则些元素在二进制的第 ii 位上的汉明距离之和为
  //

  int totalHammingDistance(List<int> nums) {
    int ans = 0, n = nums.length;
    // 遍历数组
    for (int i = 0; i < 30; i++) {
      int c = 0;
      // 遍历value，获取各自汉明距离
      for (int value in nums) {
        c += (value >> i) & 1;
      }
      ans += c * (n - c);
    }
    return ans;
  }

  bool checkSubarraySum(List<int> nums, int k) {
    var len = nums.length;
    var reminder = 0;
    var map = Map<int, int>();
    map[0] = -1;
    for (int i = 0; i < len; i++) {
      reminder = (nums[i] + reminder) & k;
      if (map.containsKey(reminder)) {
        var prevIndex = map[reminder];
        if (i - prevIndex >= 2) {
          return true;
        } else {
          map[reminder] = i;
        }
      }
    }
    return false;
  }

  // https://leetcode-cn.com/problems/contiguous-array/
  int findMaxLength(List<int> nums) {
    var maxLen = 0;
    var counter = 0;
    var map = Map<int, int>();
    map[0] = -1;
    for (int i = 0; i < nums.length; i++) {
      int num = nums[i];
      if (num == 1) {
        counter++;
      } else {
        counter--;
      }

      if (map.containsKey(counter)) {
        int prevIndex = map[counter];
        maxLen = max(maxLen, i - prevIndex);
      } else {
        map[counter] = i;
      }
    }
    return maxLen;
  }

  // https://leetcode-cn.com/problems/stone-game/
  bool stoneGame(List<int> piles) {
    int n = piles.length;
    List<List<int>> f = List.generate(
        n + 2, (index) => List<int>.generate(n + 2, (index) => 0));
    for (int len = 1; len <= n; len++) {
      // dp
      for (int l = 1; l + len - 1 <= n; l++) {
        // left
        int r = l + len - 1; // right
        int a = piles[l - 1] - f[l + 1][r];
        int b = piles[r - 1] - f[l][r - 1];
        f[l][r] = max(a, b);
      }
    }
    return f[1][n] > 0;
  }
}
