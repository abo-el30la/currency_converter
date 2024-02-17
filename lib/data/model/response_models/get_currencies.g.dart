// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_currencies.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyAdapter extends TypeAdapter<Currency> {
  @override
  final int typeId = 0;

  @override
  Currency read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Currency(
      symbol: fields[0] as String?,
      name: fields[1] as String?,
      symbolNative: fields[2] as String?,
      decimalDigits: fields[3] as int?,
      rounding: fields[4] as int?,
      code: fields[5] as String?,
      namePlural: fields[6] as String?,
      type: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Currency obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.symbol)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.symbolNative)
      ..writeByte(3)
      ..write(obj.decimalDigits)
      ..writeByte(4)
      ..write(obj.rounding)
      ..writeByte(5)
      ..write(obj.code)
      ..writeByte(6)
      ..write(obj.namePlural)
      ..writeByte(7)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
