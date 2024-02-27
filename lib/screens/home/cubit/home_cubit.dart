import 'package:bloc/bloc.dart';
import 'package:currency_converter/data/model/response_models/get_currencies.dart';
import 'package:currency_converter/data/repository/repository.dart';
import 'package:currency_converter/data/storage/hive_config.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../utils/logger.dart';

part 'home_state.dart';

/// `HomeCubit` is a class that extends `Cubit` with a state of `HomeState`.
/// It is responsible for managing the state of the home page, particularly
/// the loading and retrieval of a list of currencies.
class HomeCubit extends Cubit<HomeState> {

  /// The constructor for `HomeCubit` requires an instance of `RemoteRepository`.
  /// It also initializes the state to `HomeInitial`.
  HomeCubit({required this.remoteRepository}) : super(HomeInitial());

  /// An instance of `RemoteRepository` to fetch data from the remote server.
  final RemoteRepository remoteRepository;

  /// A boolean flag to indicate whether the currency list is being loaded.
  bool isGetCurrencyListLoading = false;

  /// A list to store the fetched currencies.
  List<Currency> currencyList = [];

  /// This method is responsible for fetching the list of currencies.
  /// It first clears the `currencyList` and sets `isGetCurrencyListLoading` to true.
  /// Then it tries to fetch the currencies from the local Hive database.
  /// If the local database is not empty, it populates `currencyList` with the local data.
  /// If the local database is empty, it fetches the data from the remote server.
  /// If the server responds with a status code other than 200, it emits `GetCurrencyListError`.
  /// If the server responds with a status code of 200, it parses the response,
  /// adds the currencies to `currencyList` and the local database, and emits `GetCurrencyListSuccess`.
  /// If any error occurs during this process, it logs the error and emits `GetCurrencyListError`.
  Future<void> getCurrencyList() async {
    try {
      currencyList.clear();
      isGetCurrencyListLoading = true;
      emit(GetCurrencyListLoading());
      Box currencyBox = await Hive.openBox<Currency>(HiveConfig.currenciesBoxName);
      if (currencyBox.isOpen && currencyBox.isNotEmpty) {
        currencyBox.toMap().forEach((key, value) {
          currencyList.add(value);
        });
      }
      if (currencyList.isNotEmpty) {
        isGetCurrencyListLoading = false;
        emit(GetCurrencyListSuccess());
        return;
      }

      final Response<dynamic> result = await remoteRepository.getCurrencyList();
      isGetCurrencyListLoading = false;

      if (result.statusCode != 200) {
        emit(GetCurrencyListError());
        return;
      }
      final GetCurrencies getCurrenciesResponse = GetCurrencies.fromJson(result.data);
      getCurrenciesResponse.data?.forEach((key, value) {
        currencyList.add(value);
        currencyBox.put(value.code, value);

      });
      logger.i(result.runtimeType);
      emit(GetCurrencyListSuccess());
    } catch (e, s) {
      logger.e(e.toString());
      logger.e(s.toString());
      isGetCurrencyListLoading = false;
      emit(GetCurrencyListError());
    }
  }
}