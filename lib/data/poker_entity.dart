
import 'package:dart_leetcode_demo/generated/json/base/json_convert_content.dart';

class PokerEntity with JsonConvert<PokerEntity> {
  List<PokerCards> cards;
}

class PokerCards with JsonConvert<PokerCards> {
  String suit;
  String value;
}
