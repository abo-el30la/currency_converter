import '../api/api.dart';

class Repository {
  Repository._();

  static final instance = Repository._();

  final ApiService _apiService = ApiService.instance;

  /// get Currency List
  Future<dynamic> getCurrencyList() async {
    return await _apiService.getCurrencies();
  }

}
