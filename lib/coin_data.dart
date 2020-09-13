import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

const apiKey = '116A2FC8-DD7F-400B-85F5-ABBC9140DFB2';

class CoinData {
  Future getCoinData({String baseCurrency, String selectedCurrency}) async {
    http.Response response = await http
        .get('$coinAPIURL/$baseCurrency/$selectedCurrency?apikey=$apiKey');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(
          'status code: ${response.statusCode}, for $baseCurrency to $selectedCurrency.');
    }
  }
}
