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

    // print("Parsing currency: $json");

    double? parseDouble(String value) {
      if (value.isEmpty) {
        return null;
      }
      try {
        return double.parse(value.replaceAll(',', ''));
      } catch (e) {
        print("Failed to parse double: $value");
        rethrow;
      }
    }

    return Currency(
      title: json['title'],
      code: json['code'],
      cbPrice: parseDouble(json['cb_price'])!,
      nbuBuyPrice: parseDouble(json['nbu_buy_price'] ?? ''),
      nbuCellPrice: parseDouble(json['nbu_cell_price'] ?? ''),
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
