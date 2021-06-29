import 'package:dart_leetcode_demo/daily.dart';
import 'package:dart_leetcode_demo/practice.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final daily = Daily();
  final practice = Practice();
  test('let us test', () {
    final practice = Practice();

    // expect(leetCodeDemo.decode([1,2,3], 1), [1,0,2,1]);

    // expect(leetCodeDemo.twoSum([3,2,4], 6), [1,2]);

    expect(practice.longestPalindrome("thisagoodoogbooksdsabba"), "goodoog");
  });

  test('do daily test', () {
    
    // expect(daily.xorOperation(5, 0), 8);
    expect(daily.nthUglyNumber(10),12);
  });
  
  
  test('5,21', (){
    expect(daily.maxUncrossedLines([2,5,1,2,5], [10,5,2,1,5,2]),3);
  });

  test((""),(){
    expect(daily.reverseParentheses("a(bcdefghijkl(mno)p)q"),"apmnolkjihgfedcbq");
  });

  test(("hammingDistance"
  ),(){
    expect(daily.hammingDistance(1,4), 2);
  });

  test((""),(){
    int a = 12;
    print("answer" +  (a & 1).toString());

  });

  test(("525. 连续数组"),(){
    expect(daily.findMaxLength([0,1,0]), 2);
  });

  test(("523. 连续的子数组和"),(){
    expect(daily.checkSubarraySum([23,2,4,6,7],6), true);
  });

  // test((''),(){
  //   expect(practice.doTest(3), 0);
  // });


  test((''),(){
    expect(daily.stoneGame([5,3,4,5]), true);
  });


  test((''),(){
    practice.getTakoAndIKaCount(2, 18);
    practice.getTakoAndIKaCount2(2, 18);
  });


  test((''),(){
      List<int> array = [1,1,3,3,5];
      int x = 0;
      array.forEach((element) {
        x ^= element;
      });
      print('this is $x');

  });

}
