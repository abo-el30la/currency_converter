import 'package:dio/dio.dart';

import '../api.dart';


class ApiService {
  ApiService._();

  static final instance = ApiService._();

  final _apiClient = ApiClient.instance.getApiClient();

  /// this method is used to get the latest exchange rates
  /// ex. currencies=USD,EUR,GBP
  /// ex. base_currency=USD
  Future<Response<dynamic>> getLatestRates({
    String currencies = '',
    String baseCurrency = 'USD',
  }) async {
    return _apiClient.get(
      '/v1/latest',
      queryParameters: {
        'apikey': ServiceConst.apiKey,
        'currencies': currencies,
        'base_currency': baseCurrency,
      },
    );
  }

  /// get currency list
  Future<dynamic> getCurrencies({String? currencies}) async {
    return _apiClient.get(
      '/v1/currencies',
      queryParameters: {
        'apikey': ServiceConst.apiKey,
        'currencies': currencies,
      },
    );
  }

  /// get currencies flags
}
