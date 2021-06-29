import 'dart:async';

import 'package:dart_leetcode_demo/data/poker_entity.dart';
import 'package:dart_leetcode_demo/util/data_util.dart';
import 'package:flutter/material.dart';

class PokerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: getPokers(),
        builder: (BuildContext context, AsyncSnapshot<PokerEntity> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('error'));
            } else {
              String value = '';
              snapshot.data.cards.forEach((element) {
                value = value + element.suit + element.value + ',';
              });

              return Container(
                child: Text('$value'),
              );
            }
          }
          return Center(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        },
      )),
    );
  }

  Future<PokerEntity> getPokers() async {
    PokerEntity pokerEntity;
    await Future.delayed(const Duration(seconds: 5), () {
      pokerEntity = PokerEntity().fromJson(DataUtil.createMockData(5));
    });
    return pokerEntity;
  }

  String getMaxValue(PokerEntity pokerEntity) {
    Map<String, String> pokerMap = Map();
    Map<String, String> pokerMapR = Map();
    List<int> values = [];

    pokerEntity.cards.forEach((element) {
      pokerMap[element.value] = element.suit;
      pokerMapR[element.suit] = element.value;
      values.add(getIntValue(element.value));
    });
    if (pokerMap.length == 1 && pokerMapR.length == 1) {
      String valueTemp = pokerMap.values.first;
      if (valueTemp == 'T' ||
          valueTemp == 'J' ||
          valueTemp == 'Q' ||
          valueTemp == 'K' ||
          valueTemp == 'A') {
        return 'ロイヤルストレートフラッシュ(同じ柄の T J Q K A)';
      }
    }
    values.sort();
    int valueSum1 = 0;
    int valueSum2 = values[0];
    for (int i = 0; 0 < values.length; i++) {
      valueSum1 += values[i];
      valueSum2 += valueSum2 + 1;
    }
    bool isContinuous = valueSum1 == valueSum2;

    if (pokerMapR.length == 1 && isContinuous) {
      return 'ストレートフラッシュ(ストレートででかつフラッシュ) ';
    }
    if (pokerMap.length == 2) {
      int witchHouse = 0;
      for (int i = 0; i < values.length - 1; i++) {}
      values.forEach((element) {
        if (element == getIntValue(pokerMap.keys.first)) {
          witchHouse++;
        }
      });
      if (witchHouse == 4 || witchHouse == 1) {
        return 'フォーカード(同じ数字4枚) ';
      } else {
        return 'フルハウス(ワンペアとスリーカード)';
      }
    }
    if (pokerMap.length == 1) {
      return 'フラッシュ(同じ柄が5枚)';
    }

    if (isContinuous) {
      return 'ストレート(連番で5枚、柄は自由)';
    }

    if (pokerMap.length == 3) {
      return 'スリーカード (同じ数字のカードが3つある)';
    }
    if (pokerMap.length == 4) {
      return 'ワンペア(同じ数字のペアが1つある)';
    }

    return 'ハイカード(役のない状態)';
  }

  int getIntValue(String value) {
    try {
      return int.parse(value);
    } catch (e) {
      switch (value) {
        case 'A':
          return 14;
        case 'K':
          return 13;
        case 'Q':
          return 12;
        case 'J':
          return 11;
        case 'T':
          return 10;
        default:
          return 0;
      }
    }
  }
}
