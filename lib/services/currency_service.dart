import 'dart:convert';
import 'package:exchange_rate/data/models/currency.dart';
import 'package:http/http.dart' as http;

class CurrencyService {
  Future<List<Currency>> getCurrencies() async {
    try {
      Uri url = Uri.parse("https://nbu.uz/uz/exchange-rates/json/");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Currency> currencies =
            data.map((currency) => Currency.fromJson(currency)).toList();

        return currencies;
      } else {
        throw Exception('Failed to load currencies');
      }
    } catch (e) {
      print("Get qilishda hatolik bo'ldi: $e");
      throw Exception("Xatolik yuz berdi: $e");
      // rethrow;
    }
  }
}
