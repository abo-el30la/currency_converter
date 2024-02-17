import 'package:bloc/bloc.dart';
import 'package:currency_converter/data/model/response_models/get_currencies.dart';
import 'package:currency_converter/data/repository/repository.dart';
import 'package:currency_converter/data/storage/hive_config.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../utils/logger.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  bool isGetCurrencyListLoading = false;
  List<Currency> currencyList = [];

  Future<void> getCurrencyList() async {
    try {
      currencyList.clear();
      isGetCurrencyListLoading = true;
      emit(GetCurrencyListLoading());

      Box<Currency> currencyBox = Hive.box<Currency>(HiveConfig.currenciesBoxName);
      currencyBox.toMap().forEach((key, value) {
        currencyList.add(value);
      });
      if(currencyList.isNotEmpty){
        isGetCurrencyListLoading = false;
        emit(GetCurrencyListSuccess());
        return;
      }

      final Response<dynamic> result = await Repository.instance.getCurrencyList();
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
