import 'package:bloc/bloc.dart';
import 'package:currency_converter/data/model/response_models/get_currencies.dart';
import 'package:currency_converter/data/repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

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
      final Response<dynamic> result = await Repository.instance.getCurrencyList();
      isGetCurrencyListLoading = false;

      if (result.statusCode != 200) {
        emit(GetCurrencyListError());
        return;
      }
      final GetCurrencies getCurrenciesResponse = GetCurrencies.fromJson(result.data);
      getCurrenciesResponse.data?.forEach((key, value) {
        currencyList.add(value);
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
