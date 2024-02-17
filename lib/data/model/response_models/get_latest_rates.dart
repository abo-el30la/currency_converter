import 'dart:convert';

class GetLatestRates {
  final Map<String, double>? data;

  GetLatestRates({
    this.data,
  });

  factory GetLatestRates.fromRawJson(String str) => GetLatestRates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetLatestRates.fromJson(Map<String, dynamic> json) => GetLatestRates(
    data: Map.from(json["data"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
