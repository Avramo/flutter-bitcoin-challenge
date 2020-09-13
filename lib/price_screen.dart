import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'dart:io' show Platform;
import 'coin_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();
  Map<String, String> rates = {
    'BTC': '?',
    'ETH': '?',
    'LTC': '?',
  };

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          print(selectedCurrency);
          getData(selectedCurrency);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(currenciesList[selectedIndex]);
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
        getData(currenciesList[selectedIndex]);
      },
      children: pickerItems,
    );
  }

  void getData(String selectedCurrency) async {
//    for (int i = 0; i < cryptoList.length; i++) {
    String baseCurrency = cryptoList[0];
    var data = await coinData.getCoinData(
        baseCurrency: baseCurrency, selectedCurrency: selectedCurrency);

    var decodedData = jsonDecode(data);
    String base = decodedData['asset_id_base'];
    double rate = decodedData['rate'];
    print('base: $base, selectedCurrency: $selectedCurrency, rate: $rate');
    String rateString = rate.toStringAsFixed(2);
    setState(() {
      this.selectedCurrency = selectedCurrency;
      this.rates[baseCurrency] = rateString;
    });
//    }
  }

  @override
  void initState() {
    super.initState();
    getData(selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Coin_card(
              base: 'BTC',
              rate: rates['BTC'],
              selectedCurrency: selectedCurrency),
          Coin_card(
              base: 'ETH',
              rate: rates['ETH'],
              selectedCurrency: selectedCurrency),
          Coin_card(
              base: 'LTC',
              rate: rates['LTC'],
              selectedCurrency: selectedCurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
