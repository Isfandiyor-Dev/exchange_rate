import 'package:exchange_rate/data/models/currency.dart';
import 'package:exchange_rate/ui/widgets/my_bottom_sheet.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController firstTextController =
      TextEditingController(text: "0");

  final TextEditingController secondTextController =
      TextEditingController(text: "0");

  Currency? firstCurrency;
  Currency? secondCurrency;

  @override
  void initState() {
    super.initState();
  }

  void onChanged({
    required String? value,
    required Currency firstCurrency,
    required Currency secondCurrency,
    required bool isFirstField,
  }) {
    if (isFirstField) {
      double result =
          (firstCurrency.nbuBuyPrice! / secondCurrency.nbuBuyPrice!) *
              double.parse(firstTextController.text);
      secondTextController.text = result.toStringAsFixed(3);
    } else {
      double result =
          (secondCurrency.nbuBuyPrice! / firstCurrency.nbuBuyPrice!) *
              double.parse(secondTextController.text);
      firstTextController.text = result.toStringAsFixed(3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Konvertatsiya"),
        actions: [
          IconButton(
            onPressed: () {
              firstTextController.text = "0";
              secondTextController.text = "0";
            },
            icon: const Icon(
              Icons.clear_rounded,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    var currency = await showModalBottomSheet(
                      context: context,
                      builder: (ctx) => const MyBottomSheet(),
                    );
                    if (currency != null) {
                      firstCurrency = currency;
                      setState(() {});
                    }
                  },
                  label: Text(
                    firstCurrency?.code ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 35,
                  ),
                  iconAlignment: IconAlignment.end,
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      if (firstCurrency != null && secondCurrency != null) {
                        onChanged(
                          value: value,
                          firstCurrency: firstCurrency!,
                          secondCurrency: secondCurrency!,
                          isFirstField: true,
                        );
                      }
                    },
                    controller: firstTextController,
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    var currency = await showModalBottomSheet(
                      context: context,
                      builder: (ctx) => const MyBottomSheet(),
                    );
                    if (currency != null) {
                      secondCurrency = currency;
                      setState(() {});
                    }
                  },
                  label: Text(
                    secondCurrency?.code ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 35,
                  ),
                  iconAlignment: IconAlignment.end,
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      if (firstCurrency != null && secondCurrency != null) {
                        onChanged(
                          value: value,
                          firstCurrency: firstCurrency!,
                          secondCurrency: secondCurrency!,
                          isFirstField: false,
                        );
                      }
                    },
                    controller: secondTextController,
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusColor: Colors.orange,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
