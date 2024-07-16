import 'package:exchange_rate/data/models/currency.dart';

sealed class CurrencyState {
  final List<Currency> currencies;

  CurrencyState(this.currencies);
}

final class InitialCurrencyState extends CurrencyState {
  InitialCurrencyState(super.currencies);
}

final class LoadingCurrencyState extends CurrencyState {
  LoadingCurrencyState(super.currencies);
}

final class LoadedCurrencyState extends CurrencyState {
  LoadedCurrencyState(super.currencies);
}

final class ErrorCurrencyState extends CurrencyState {
  final String message;

  ErrorCurrencyState(super.currencies, this.message);
}
