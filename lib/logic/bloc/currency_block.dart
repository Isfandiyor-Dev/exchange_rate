import 'package:bloc/bloc.dart';
import 'package:exchange_rate/data/models/currency.dart';
import 'package:exchange_rate/data/repositories/currency_repository.dart';
import 'package:exchange_rate/logic/bloc/currency_events.dart';
import 'package:exchange_rate/logic/bloc/currency_state.dart';
import 'package:stream_transform/stream_transform.dart';

class CurrencyBloc extends Bloc<CurrencyEvents, CurrencyState> {
  final CurrencyRepository _currencyRepository;
  List<Currency> allCurrencies = [];

  CurrencyBloc({required CurrencyRepository currencyRepository})
      : _currencyRepository = currencyRepository,
        super(InitialCurrencyState([])) {
    on<GetCurrency>(_getCurrency);
    on<SearchCurrency>(_searchCurrencies, transformer: _debounce());
  }

  Future<void> _getCurrency(
      GetCurrency event, Emitter<CurrencyState> emit) async {
    emit(LoadingCurrencyState([]));
    try {
      final currencies = await _currencyRepository.getCurrencies();
      allCurrencies = currencies;
      emit(LoadedCurrencyState(currencies));
    } catch (e) {
      emit(ErrorCurrencyState([], e.toString()));
    }
  }

  Future<void> _searchCurrencies(
      SearchCurrency event, Emitter<CurrencyState> emit) async {
    final query = event.query.toLowerCase();
    final filteredCurrencies = allCurrencies.where((currency) {
      return currency.title.toLowerCase().contains(query) ||
          currency.code.toLowerCase().contains(query);
    }).toList();
    emit(LoadedCurrencyState(filteredCurrencies));
  }

  EventTransformer<T> _debounce<T>(
      {Duration duration = const Duration(milliseconds: 300)}) {
    return (events, mapper) => events
        .debounce(const Duration(microseconds: 300), leading: false, trailing: true)
        .switchMap(mapper);
  }
}
