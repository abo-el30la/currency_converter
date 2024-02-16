import 'dart:convert';

class GetCurrencies {
  final Map<String, Currency>? data;

  GetCurrencies({
    this.data,
  });

  factory GetCurrencies.fromRawJson(String str) => GetCurrencies.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetCurrencies.fromJson(Map<String, dynamic> json) => GetCurrencies(
    data: Map.from(json["data"]!).map((k, v) => MapEntry<String, Currency>(k, Currency.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Currency {
  final String? symbol;
  final String? name;
  final String? symbolNative;
  final int? decimalDigits;
  final int? rounding;
  final String? code;
  final String? namePlural;
  final String? type;

  Currency({
    this.symbol,
    this.name,
    this.symbolNative,
    this.decimalDigits,
    this.rounding,
    this.code,
    this.namePlural,
    this.type,
  });

  factory Currency.fromRawJson(String str) => Currency.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    symbol: json["symbol"],
    name: json["name"],
    symbolNative: json["symbol_native"],
    decimalDigits: json["decimal_digits"],
    rounding: json["rounding"],
    code: json["code"],
    namePlural: json["name_plural"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "symbol": symbol,
    "name": name,
    "symbol_native": symbolNative,
    "decimal_digits": decimalDigits,
    "rounding": rounding,
    "code": code,
    "name_plural": namePlural,
    "type": type,
  };
}

