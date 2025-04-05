// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SerieAdapter extends TypeAdapter<Serie> {
  @override
  final int typeId = 0;

  @override
  Serie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Serie(
      fields[0] as String,
      (fields[1] as num).toInt(),
      (fields[2] as num).toInt(),
      fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Serie obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.anzahlStaffel)
      ..writeByte(2)
      ..write(obj.bewertung)
      ..writeByte(3)
      ..write(obj.erscheinungsjahr);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SerieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
