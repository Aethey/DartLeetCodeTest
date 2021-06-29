import 'package:dart_leetcode_demo/data/poker_entity.dart';

pokerEntityFromJson(PokerEntity data, Map<String, dynamic> json) {
	if (json['cards'] != null) {
		data.cards = (json['cards'] as List).map((v) => PokerCards().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> pokerEntityToJson(PokerEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['cards'] =  entity.cards.map((v) => v.toJson()).toList();
	return data;
}

pokerCardsFromJson(PokerCards data, Map<String, dynamic> json) {
	if (json['suit'] != null) {
		data.suit = json['suit'].toString();
	}
	if (json['value'] != null) {
		data.value = json['value'].toString();
	}
	return data;
}

Map<String, dynamic> pokerCardsToJson(PokerCards entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['suit'] = entity.suit;
	data['value'] = entity.value;
	return data;
}