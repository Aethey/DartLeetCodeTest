

import 'dart:math';

class Daily{


  // https://leetcode-cn.com/problems/xor-operation-in-an-array/

  //    给你两个整数，n 和 start 。
  //    数组 nums 定义为：nums[i] = start + 2*i（下标从 0 开始）且 n == nums.length 。
  //    请返回 nums 中所有元素按位异或（XOR）后得到的结果。

  int xorOperation (int n,int start){
    int ans = start;
    for(int i = 0; i < n; i ++ ){
      ans = ans ^ start + 2 * i;
    }
    return ans;
  }

  int nthUglyNumber(int n){
    int a = 0;
    int b = 0;
    int c = 0;
    var dp = List.filled(n, 0);
    dp[0] = 1;
    int i = 1;
    while(i < n){
      int n2 = dp[a] * 2, n3 = dp[b] * 3, n5 = dp[c] * 5;
      dp[i] = min(min(n2, n3), n5);
      if(dp[i] == n2) a++;
      if(dp[i] == n3) b++;
      if(dp[i] == n5) c++;
      i++;
    }

    return dp[n -1];
  }


  // https://leetcode-cn.com/problems/longest-common-subsequence/

  int maxUncrossedLines(List<int> num1,List<int> num2){
    int n = num1.length;
    int m = num2.length;
    List<List<int>> f = List.generate(n, (index) => List.filled(m, 0));
    for( int i = 1;i < n; i ++){
      for( int j = 1;j < m; j++){
        f[i][j] = max(f[i][j - 1],f[i - 1][j]);
        if(num1[i] == num2[j])f[i][j] = f[i - 1][j - 1] + 1;
      }
    }
    return f[n - 1][m - 1];
  }

  // https://leetcode-cn.com/problems/chalkboard-xor-game/
  bool xorGame(List<int> array){
    if(array.length % 2 == 0)return true;
    else{
      int sum = 0;
      for(int num in array){
        sum ^= num;
      }
      return sum == 0;
    }
  }
}