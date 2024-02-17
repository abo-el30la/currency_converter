part of 'converter_cubit.dart';

abstract class ConverterState {}

class ConverterInitial extends ConverterState {}

class GetCurrencyExchangeRateLoading extends ConverterState {}

class GetCurrencyExchangeRateSuccess extends ConverterState {}

class GetCurrencyExchangeRateError extends ConverterState {}

class SetBaseCurrencyState extends ConverterState {}
