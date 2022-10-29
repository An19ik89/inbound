// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbound_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataModelAdapter extends TypeAdapter<DataModel> {
  @override
  final int typeId = 0;

  @override
  DataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataModel(
      sealNo: fields[0] as String?,
      date: fields[1] as String?,
      containerSl: fields[2] as String?,
      warehouse: fields[3] as String?,
      materialNo: fields[4] as String?,
      reelNo: fields[5] as String?,
      quantity: fields[6] as String?,
      imageUrls: (fields[7] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, DataModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.sealNo)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.containerSl)
      ..writeByte(3)
      ..write(obj.warehouse)
      ..writeByte(4)
      ..write(obj.materialNo)
      ..writeByte(5)
      ..write(obj.reelNo)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.imageUrls);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
