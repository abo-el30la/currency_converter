import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/data/model/response_models/get_currencies.dart';
import 'package:currency_converter/data/repository/repository.dart';
import 'package:currency_converter/screens/home/cubit/home_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

class MockRemoteRepository extends Mock implements RemoteRepository {}

class MockHiveBox extends Mock implements Box<Currency> {}

class MockGetCurrencies extends Mock implements GetCurrencies {}


void main() {
  late HomeCubit homeCubit;
  late MockRemoteRepository mockRemoteRepository;
  late MockHiveBox mockCurrencyBox;

  setUp(() {
    mockRemoteRepository = MockRemoteRepository();
    mockCurrencyBox = MockHiveBox();
    homeCubit = HomeCubit(remoteRepository: mockRemoteRepository);
  });

  blocTest<HomeCubit, HomeState>(
    'emits [GetCurrencyListLoading, GetCurrencyListSuccess] when data is fetched successfully from Hive',
    build: () {
      when(() => mockCurrencyBox.isNotEmpty).thenReturn(() => true);
      when(() => mockCurrencyBox.toMap()).thenReturn(() => {});
      when(() => mockCurrencyBox.isOpen).thenReturn(() => true);
      return homeCubit;
    },
    act: (cubit) async {
      return cubit.getCurrencyList();
    },
    expect: () => [
      GetCurrencyListLoading(),
      GetCurrencyListSuccess(),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'emits [GetCurrencyListLoading, GetCurrencyListSuccess] when data is fetched successfully from remote',
    build: () {
      when(() => mockCurrencyBox.isNotEmpty).thenReturn(()=>false);
      // when(() => mockRemoteRepository.getCurrencyList())
      //     .thenAnswer((_) async => Response(data: {'data': {'USD': Currency(code: 'USD')}}));
      return homeCubit;
    },
    act: (cubit) => cubit.getCurrencyList(),
    expect: () => [
      GetCurrencyListLoading(),
      GetCurrencyListSuccess(),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'emits [GetCurrencyListLoading, GetCurrencyListError] when remote call fails',
    build: () {
      when(() => mockCurrencyBox.isNotEmpty).thenReturn(() => false);
      // when(() => mockRemoteRepository.getCurrencyList())
      //     .thenAnswer((_) async => Response(statusCode: 400));
      return homeCubit;
    },
    act: (cubit) => cubit.getCurrencyList(),
    expect: () => [
      GetCurrencyListLoading(),
      GetCurrencyListError(),
    ],
  );

  // Add more tests for different scenarios, error handling, etc.
}


final currencyList = {
  "AED": Currency(
    symbol: "AED",
    name: "United Arab Emirates Dirham",
    symbolNative: "د.إ",
    decimalDigits: 2,
    rounding: 0,
    code: "AED",
    namePlural: "UAE dirhams",
    type: "fiat",
  ),
  "AFN": Currency(
    symbol: "AFN",
    name: "Afghan Afghani",
    symbolNative: "؋",
    decimalDigits: 0,
    rounding: 0,
    code: "AFN",
    namePlural: "Afghan Afghanis",
    type: "fiat",
  ),
  "ALL": Currency(
    symbol: "ALL",
    name: "Albanian Lek",
    symbolNative: "Lek",
    decimalDigits: 0,
    rounding: 0,
    code: "ALL",
    namePlural: "Albanian lekë",
    type: "fiat",
  ),
};