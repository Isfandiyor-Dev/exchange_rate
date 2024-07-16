import 'package:bloc/bloc.dart';
import 'package:exchange_rate/data/repositories/currency_repository.dart';
import 'package:exchange_rate/logic/bloc/currency_events.dart';
import 'package:exchange_rate/logic/bloc/currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvents, CurrencyState> {
  final CurrencyRepository _currencyRepository;

  CurrencyBloc({required CurrencyRepository currencyRepository})
      : _currencyRepository = currencyRepository,
        super(InitialCurrencyState([])) {
    on<GetCurrency>(_getCurrency);
  }

  Future<void> _getCurrency(
      GetCurrency event, Emitter<CurrencyState> emit) async {
    emit(LoadingCurrencyState([]));
    try {
      final currencies = await _currencyRepository.getCurrencies();
      emit(LoadedCurrencyState(currencies));
    } catch (e) {
      emit(ErrorCurrencyState([], e.toString()));
    }
  }
}
