import 'package:exchange_rate/logic/bloc/currency_block.dart';
import 'package:exchange_rate/logic/bloc/currency_events.dart';
import 'package:exchange_rate/logic/bloc/currency_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: [
          Column(
            children: [
              TextField(
                onChanged: (value) {
                  context
                      .read<CurrencyBloc>()
                      .add(SearchCurrency(query: value));
                },
                decoration: const InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
              Expanded(
                child: BlocBuilder<CurrencyBloc, CurrencyState>(
                  builder: (context, state) {
                    if (state is LoadingCurrencyState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LoadedCurrencyState) {
                      return ListView.builder(
                        itemCount: state.currencies.length,
                        itemBuilder: (context, index) {
                          final currency = state.currencies[index];
                          return ListTile(
                            onTap: () {
                              if (currency.nbuBuyPrice != null ||
                                  currency.nbuCellPrice != null) {
                                Navigator.pop(context, currency);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text(
                                        "${currency.title} (${currency.code}) uchun NBU narxlari mavjud emas"),
                                    actions: [
                                      FilledButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Ok"),
                                      ),
                                    ],
                                    actionsAlignment: MainAxisAlignment.center,
                                  ),
                                );
                              }
                            },
                            title: Text("${currency.title} ${currency.code}"),
                          );
                        },
                      );
                    } else if (state is ErrorCurrencyState) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else {
                      return const Center(child: Text('No Data'));
                    }
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      fixedSize: const Size(double.infinity, 55),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
