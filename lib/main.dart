import 'package:exchange_rate/core/app.dart';
import 'package:exchange_rate/data/repositories/currency_repository.dart';
import 'package:exchange_rate/logic/bloc/currency_block.dart';
import 'package:exchange_rate/logic/bloc/currency_events.dart';
import 'package:exchange_rate/services/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CurrencyService>(
          create: (context) => CurrencyService(),
        ),
        RepositoryProvider<CurrencyRepository>(
          create: (context) => CurrencyRepository(
            currencyService: context.read<CurrencyService>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CurrencyBloc>(
            create: (context) => CurrencyBloc(
              currencyRepository: context.read<CurrencyRepository>(),
            )..add(GetCurrency()),
          ),
        ],
        child: const MainApp(),
      ),
    ),
  );
}
