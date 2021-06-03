import 'dart:collection';

class Practice {
// https://leetcode-cn.com/problems/decode-xored-array/
  List<int> decode(List<int> encoded, int first) {
    int len = encoded.length;
    List<int> ans = List.filled(len + 1, 0);
    ans[0] = first;
    for (int i = 0; i < len; i++) {
      ans[i + 1] = encoded[i] ^ ans[i];
    }
    return ans;
  }

  // https://leetcode-cn.com/problems/two-sum/
  List<int> twoSum(List<int> nums, int target) {
    List<int> ans = List.filled(2, 0);
    if (nums.length == 2) {
      ans[0] = 0;
      ans[1] = 1;
    }

    int x = 0;
    while (x + 1 < nums.length) {
      for (int i = x + 1; i < nums.length; i++) {
        if (nums[x] + nums[i] == target) {
          ans[0] = x;
          ans[1] = i;
          break;
        } else {
          continue;
        }
      }
      x++;
    }
    return ans;
  }

  // https://leetcode-cn.com/problems/longest-palindromic-substring/
  String longestPalindrome(String s) {
    int len = s.length;
    if (len < 2) {
      return s;
    }

    int maxLen = 1;
    int begin = 0;
    List<List<bool>> dp =
        List.generate(len, (index) => List.filled(len, false));

    for (int i = 0; i < len; i++) {
      dp[i][i] = true;
    }

    for (int L = 2; L <= len; L++) {
      for (int i = 0; i < len; i++) {
        int j = L + i - 1;
        if (j >= len) {
          break;
        }
        if (s[i] != s[j]) {
          dp[i][j] = false;
        } else {
          if (j - i < 3) {
            dp[i][j] = true;
          } else {
            dp[i][j] = dp[i + 1][j - 1];
          }
        }
        if (dp[i][j] && j - i + 1 > maxLen) {
          maxLen = j - i + 1;
          begin = i;
        }
      }
    }
    return s.substring(begin, begin + maxLen);
  }

// https://leetcode-cn.com/problems/reverse-substrings-between-each-pair-of-parentheses/

  String reverseParentheses(String s) {
    var len = s.length;
    var pair = [len];
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
}
