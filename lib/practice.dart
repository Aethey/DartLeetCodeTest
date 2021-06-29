import 'dart:collection';
import 'dart:math';

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

  int doTest(int x) {
    return x ^= 4;
  }

  /// タコとイカそれぞれの数を計算
  /// n タコとイカの数
  /// m タコとイカの足の数
  void getTakoAndIKaCount(int n, int m) {
    int takoCount = 0;
    int ikaCount = n - 0;
    while (takoCount <= n) {
      if ((takoCount * 8 + ikaCount * 10) == m) {
        print('タコの数は$takoCountの場合,イカの数は$ikaCount');
      }
      takoCount++;
      ikaCount--;
    }
  }

  /// タコとイカそれぞれの数を計算
  /// n タコとイカの数
  /// m タコとイカの足の数
  void getTakoAndIKaCount2(int n, int m) {
    int takoCount = 0;
    int ikaCount = 0;
    if ((m - n * 8) % 2 == 0) {
      ikaCount = (m - n * 8) ~/ 2;
      takoCount = n - ikaCount;
      print('other');
      print('タコの数は$takoCountの場合,イカの数は$ikaCount');
    } else {
      print('数字が合わないです。');
    }
  }

  // https://leetcode-cn.com/problems/merge-sorted-array/submissions/

  // time complexity: O(m+n)
  // space complexity: O(1)
  void merge(List<int> nums1, int m, List<int> nums2, int n) {
    int p1 = m - 1, p2 = n - 1;
    int cur;
    int tail = m + n - 1;
    while (p1 >= 0 || p2 >= 0) {
      if (p1 == -1) {
        cur = nums2[p2--];
      } else if (p2 == -1) {
        cur = nums1[p1--];
      } else if (nums1[p1] > nums2[p2]) {
        cur = nums1[p1--];
      } else {
        cur = nums2[p2--];
      }
      nums1[tail--] = cur;
    }
  }

  // time complexity: O(nums.length)
  // space complexity: O(1)
  int removeDuplicates(List<int> nums) {
    int k = 2, u = 0;
    for (int num in nums) {
      if (u < k || nums[u - k] != num) {
        nums[u++] = num;
      }
    }
    return u;
  }

  int removeDuplicates2(List<int> nums) {
    int n = nums.length;
    if (n < 2) {
      return n;
    }
    int slow = 2, fast = 2;
    while (fast < n) {
      if (nums[slow - 2] != nums[fast]) {
        nums[slow] = nums[fast];
        slow++;
      }
      fast++;
    }
    return slow;
  }

  bool search(List<int> nums, int target) {
    int len = nums.length;
    int l = 0, r = len - 1;
    while (l < r && nums[0] == nums[r]) r--;

    while (l < r) {
      int mid = l + r + 1 >> 1;
      if (nums[mid] >= nums[0]) {
        l = mid;
      } else {
        r = mid - 1;
      }
    }

    int idx = len;
    if (nums[r] >= nums[0] && r + 1 < len) idx = r + 1;
    int ans = find(nums, 0, idx - 1, target);
    if (ans != -1) return true;
    ans = find(nums, idx, len - 1, target);
    return ans != -1;
  }

  int find(List<int> nums, int l, int r, int t) {
    while (l < r) {
      int mid = l + r + 1 >> 1;
      if (nums[mid] > t) {
        r = mid;
      } else {
        l = mid + 1;
      }
    }
    return nums[r] == t ? r : -1;
  }

  bool search2(List<int> nums, int target) {
    int len = nums.length;
    int l = 0;
    int r = len - 1;
    while (l < r && nums[0] == nums[r]) r--;
    while (l < r) {
      int mid = l + r + 1 >> 1;
      if (nums[mid] > target) {
        l = mid;
      } else {
        r = mid + 1;
      }
    }

    int idx = len;
    if (nums[r] >= nums[0] && r + 1 < len) idx = r + 1;
    int ans = find2(0, idx - 1, nums, target);
    if (ans != -1) return true;
    ans = find2(idx, len - 1, nums, target);
    return ans != -1;
  }

  int find2(int l, int r, List<int> nums, int t) {
    while (l < r) {
      int mid = l + r + 1 >> 1;
      if (nums[mid] > t) {
        l = mid;
      } else {
        r = mid + 1;
      }
    }
    return nums[r] == t ? t : -1;
  }

  int maxSubArray(List<int> nums) {
    int pre = 0, maxAns = nums[0];
    for (int x in nums) {
      pre = max(pre + x, x);
      maxAns = max(maxAns, pre);
    }
    return maxAns;
  }

  void stepDp(int x) {
    List<int> dp = List.filled(x, 0);
    dp[1] = 1;
    dp[2] = 2;

    for (int step = 3; step <= x; step++) {
      dp[step] = dp[step - 1] + dp[step - 2];
    }
    print('${dp[x]}');
  }
}
