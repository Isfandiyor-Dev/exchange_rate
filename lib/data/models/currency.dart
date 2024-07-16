import 'package:intl/intl.dart';

class Currency {
  final String title;
  final String code;
  final double cbPrice;
  final double? nbuBuyPrice;
  final double? nbuCellPrice;
  final DateTime date;

  Currency({
    required this.title,
    required this.code,
    required this.cbPrice,
    required this.nbuBuyPrice,
    required this.nbuCellPrice,
    required this.date,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm:ss');
    return Currency(
      title: json['title'],
      code: json['code'],
      cbPrice: double.parse(json['cb_price']),
      nbuBuyPrice: json['nbu_buy_price'] != null
          ? double.parse(json['nbu_buy_price'])
          : null,
      nbuCellPrice: json['nbu_cell_price'] != null
          ? double.parse(json['nbu_cell_price'])
          : null,
      date: dateFormat.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm:ss');
    return {
      'title': title,
      'code': code,
      'cb_price': cbPrice.toString(),
      'nbu_buy_price': nbuBuyPrice?.toString(),
      'nbu_cell_price': nbuCellPrice?.toString(),
      'date': dateFormat.format(date),
    };
  }
}
