import 'package:http/http.dart';
import 'dart:convert';
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

const apiKey = '28F297AC-3991-4E5D-8461-8C5158960F9D';

class CoinData {

  Future getCoinData({required String currency}) async{
    var baseURL = Uri.https('rest.coinapi.io', 'v1/exchangerate/BTC/$currency');
    Response response = await get(baseURL, headers: {
      'X-CoinAPI-Key' : apiKey
    });

    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      //Update the URL to use the crypto symbol from the cryptoList
      var baseURL = Uri.https('rest.coinapi.io', 'v1/exchangerate/$crypto/$currency');
      Response response = await get(baseURL, headers: {
        'X-CoinAPI-Key' : apiKey
      });
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }

    return cryptoPrices;
  }
}