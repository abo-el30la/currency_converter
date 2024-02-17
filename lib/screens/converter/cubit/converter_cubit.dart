import 'package:bloc/bloc.dart';
import 'package:currency_converter/data/model/response_models/get_latest_rates.dart';
import 'package:currency_converter/data/repository/repository.dart';
import 'package:currency_converter/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../data/model/response_models/get_currencies.dart';
import '../../../data/storage/hive_config.dart';

part 'converter_state.dart';

class ConverterCubit extends Cubit<ConverterState> {
  TextEditingController amountController = TextEditingController();
  TextEditingController targetAmountController = TextEditingController();

  ConverterCubit() : super(ConverterInitial());
  String baseCurrency = 'USD';
  String targetCurrency = 'USD';
  double exchangeRate = 1.0;
  List<Currency> currenciesList = [];
  Map<String, double> exchangeRates = {};


  void setBaseCurrency(String currency) async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    if (!hasConnection) {
      emit(NoInternetState());
      return;
    }
    if (currency == baseCurrency) {
      return;
    }
    baseCurrency = currency;
    exchangeRate = exchangeRates[targetCurrency] ?? 1.0;

    emit(SetBaseCurrencyState());
    await getCurrencyExchangeRate();

    if (amountController.text.isNotEmpty) {
      convertCurrency();
    }
  }

  void setTargetCurrency(String currency) {
    targetCurrency = currency;
    exchangeRate = exchangeRates[targetCurrency] ?? 1.0;
    if (amountController.text.isNotEmpty) {
      convertCurrency();
    }
    emit(SetTargetCurrencyState());
  }

  void getBaseCurrenciesList() {
    Box<Currency> currencyBox = Hive.box<Currency>(HiveConfig.currenciesBoxName);
    currencyBox.toMap().forEach((key, value) {
      currenciesList.add(value);
    });
    emit(GetBaseCurrenciesListState());
  }

  bool isGetCurrencyExchangeRateLoading = false;

  Future<void> getCurrencyExchangeRate() async {
    try {
      bool hasConnection = await InternetConnectionChecker().hasConnection;
      if (!hasConnection) {
        emit(NoInternetState());
        return;
      }
      isGetCurrencyExchangeRateLoading = true;
      emit(GetCurrencyExchangeRateLoading());
      // if (exchangeRates.isNotEmpty) {
      //   exchangeRate = exchangeRates[targetCurrency] ?? 1.0;
      //   isGetCurrencyExchangeRateLoading = false;
      //   emit(GetCurrencyExchangeRateSuccess());
      //   return;
      // }
      final Response result = await Repository.instance.getLatestRates(
        baseCurrency: baseCurrency,
      );
      logger.i(result.runtimeType);
      if (result.statusCode != 200) {
        isGetCurrencyExchangeRateLoading = false;
        emit(GetCurrencyExchangeRateError());
        return;
      }
      GetLatestRates getLatestRatesResponse = GetLatestRates.fromJson(result.data);
      exchangeRates = getLatestRatesResponse.data ?? {};
      exchangeRate = exchangeRates[targetCurrency] ?? 1.0;
      isGetCurrencyExchangeRateLoading = false;
      emit(GetCurrencyExchangeRateSuccess());
    } catch (e, s) {
      isGetCurrencyExchangeRateLoading = false;
      logger.e(e.toString());
      logger.e(s.toString());
      emit(GetCurrencyExchangeRateError());
    }
  }

  void convertCurrency() {
    double amount = double.tryParse(amountController.text) ?? 0.0;
    double targetAmount = amount * exchangeRate;
    targetAmountController.text = targetAmount.toStringAsFixed(2);
    emit(ConvertCurrencyState());
  }

  void swapCurrencies() async {
    String temp = baseCurrency;
    baseCurrency = targetCurrency;
    targetCurrency = temp;
    emit(SwapCurrencyState());
    await getCurrencyExchangeRate();
    if (amountController.text.isNotEmpty) {
      convertCurrency();
    }
  }
}
