import '../api/api.dart';

class Repository {
  Repository._();

  static final instance = Repository._();

  final ApiService _apiService = ApiService.instance;

  /// get Currency List
  Future<dynamic> getCurrencyList() async {
    return await _apiService.getCurrencies();
  }

  /// get latest exchange rates
  Future<dynamic> getLatestRates({
    String currencies = '',
    String baseCurrency = 'USD',
  }) async {
    return await _apiService.getLatestRates(
      currencies: currencies,
      baseCurrency: baseCurrency,
    );
  }

}
