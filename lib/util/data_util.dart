import 'dart:math';

import 'package:dart_leetcode_demo/data/poker_entity.dart';


/// create mock data
class DataUtil {
  static Map<String, dynamic> createMockData(int len) {
    Random random = Random();
    List<String> suits = ['S', 'H', 'C', 'D'];
    List<String> values = [
      'A',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      'T',
      'J',
      'Q',
      'K'
    ];
    PokerEntity pokerEntity = PokerEntity();
    List<PokerCards> cards = List.generate(len, (index) {
      PokerCards pokerCards = PokerCards();
      pokerCards.suit = suits[random.nextInt(suits.length - 1)];
      pokerCards.value = values[random.nextInt(values.length - 1)];
      return pokerCards;
    });
    pokerEntity.cards = cards;
    return pokerEntity.toJson();
  }
}
