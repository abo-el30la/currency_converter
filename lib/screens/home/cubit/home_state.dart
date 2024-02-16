part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetCurrencyListLoading extends HomeState {}

class GetCurrencyListSuccess extends HomeState {}

class GetCurrencyListError extends HomeState {}