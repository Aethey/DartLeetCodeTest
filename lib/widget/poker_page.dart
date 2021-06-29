import 'dart:async';

import 'package:dart_leetcode_demo/data/poker_entity.dart';
import 'package:dart_leetcode_demo/util/data_util.dart';
import 'package:flutter/material.dart';

class PokerPage extends StatelessWidget {
  final _streamController = StreamController<PokerEntity>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getPokers();
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
        stream: _streamController.stream,
        builder: (BuildContext context, AsyncSnapshot<PokerEntity> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasError) {
              return Center(child: Text('error'));
            } else {
              String value = '';
              String poker = '';
              snapshot.data.cards.forEach((element) {
                poker = poker + element.suit + element.value + ',';
              });

              value = getMaxValue(snapshot.data);

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('$poker'),
                    Text('$value'),
                    Container(
                      width: size.width / 2,
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.cards.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: size.width / 10,
                            height: 100,
                            child: Container(
                              color: Colors.grey,
                              margin: const EdgeInsets.all(2.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('${snapshot.data.cards[index].value}'),
                                    Text('${snapshot.data.cards[index].suit}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          getPokers();
                        },
                        child: Icon(Icons.ac_unit))
                  ],
                ),
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

  Future<void> getPokers() async {
    PokerEntity pokerEntity;
    await Future.delayed(const Duration(seconds: 1), () {
      pokerEntity = PokerEntity().fromJson(DataUtil.createMockData(5));
    });

    _streamController.sink.add(pokerEntity);
  }

  String getMaxValue(PokerEntity pokerEntity) {
    Map<String, String> pokerMap = Map();
    Map<String, String> pokerMapR = Map();
    Map<String, int> pokerValueTime = Map();
    List<int> values = [];

    pokerEntity.cards.forEach((element) {
      pokerMap[element.value] = element.suit;
      pokerMapR[element.suit] = element.value;
      if (!pokerValueTime.containsKey(element.value)) {
        pokerValueTime[element.value] = 1;
      } else {
        pokerValueTime[element.value] += 1;
      }
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
    for (int i = 0; i < values.length; i++) {
      valueSum1 += values[i];
      valueSum2 += valueSum2 + 1;
    }
    bool isContinuous = valueSum1 == valueSum2;

    if (pokerMapR.length == 1 && isContinuous) {
      return 'ストレートフラッシュ(ストレートででかつフラッシュ) ';
    }
    if (pokerMap.length == 2) {
      if (pokerValueTime.values.first == 4 ||
          pokerValueTime.values.first == 1) {
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
      if (pokerValueTime.values.first != 2 && pokerValueTime.values.last != 2) {
        return 'スリーカード (同じ数字のカードが3つある)';
      } else {
        return 'ツーペア (同じ数字のペアが2つある)';
      }
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

  void close() {
    _streamController.close();
  }
}
