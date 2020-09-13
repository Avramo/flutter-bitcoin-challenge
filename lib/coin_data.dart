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

const apiKey = 'D4879062-F860-4BD4-A26B-8CB90B725250';

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
