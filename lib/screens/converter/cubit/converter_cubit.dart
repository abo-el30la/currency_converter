import 'package:bloc/bloc.dart';
import 'package:currency_converter/data/model/response_models/get_latest_rates.dart';
import 'package:currency_converter/data/repository/repository.dart';
import 'package:currency_converter/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

part 'converter_state.dart';

class ConverterCubit extends Cubit<ConverterState> {
  TextEditingController amountController = TextEditingController();

  ConverterCubit() : super(ConverterInitial());
  String baseCurrency = 'USD';
  String targetCurrency = 'USD';
  double exchangeRate = 1.0;
  void setBaseCurrency(String currency) {
    baseCurrency = currency;
    emit(SetBaseCurrencyState());
    getCurrencyExchangeRate();
  }

  void setTargetCurrency(String currency) {
    targetCurrency = currency;
    emit(SetBaseCurrencyState());
    getCurrencyExchangeRate();
  }


  Future<void> getCurrencyExchangeRate() async {
    try {
      emit(GetCurrencyExchangeRateLoading());
      final Response result = await Repository.instance.getLatestRates(
        baseCurrency: baseCurrency,
      );
      logger.i(result.runtimeType);
      if(result.statusCode != 200) {
        emit(GetCurrencyExchangeRateError());
        return;
      }
      GetLatestRates getLatestRatesResponse = GetLatestRates.fromJson(result.data);
      exchangeRate = getLatestRatesResponse.data?[targetCurrency] ?? 1.0;
      emit(GetCurrencyExchangeRateSuccess());

    } catch (e, s) {
      logger.e(e.toString());
      logger.e(s.toString());
      emit(GetCurrencyExchangeRateError());
    }
  }
}
