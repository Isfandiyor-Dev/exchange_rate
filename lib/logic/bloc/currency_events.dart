sealed class CurrencyEvents {}

final class GetCurrency extends CurrencyEvents {}

final class SearchCurrency extends CurrencyEvents {
  final String query;

  SearchCurrency({required this.query});
}
