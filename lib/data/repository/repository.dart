import '../api/api.dart';

abstract class RemoteRepository {
  Future<dynamic> getCurrencyList();
  Future<dynamic> getLatestRates({
    String currencies,
    String baseCurrency,
  });
}

class Repository implements RemoteRepository{
  Repository._();

  static final instance = Repository._();

  final ApiService _apiService = ApiService.instance;

  /// get Currency List
  @override
  Future<dynamic> getCurrencyList() async {
    return await _apiService.getCurrencies();
  }

  /// get latest exchange rates
  @override
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
