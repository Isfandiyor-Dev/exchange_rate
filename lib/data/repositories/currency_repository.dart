import 'package:exchange_rate/data/models/currency.dart';
import 'package:exchange_rate/services/currency_service.dart';

class CurrencyRepository {
  final CurrencyService currencyService;

  CurrencyRepository({required this.currencyService});

  Future<List<Currency>> getCurrencies() async {
    return await currencyService.getCurrencies();
  }
}
