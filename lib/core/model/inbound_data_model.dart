import 'dart:convert';
import 'package:hive/hive.dart';
part 'inbound_data_model.g.dart';

List<DataModel> dataModelFromJson(String str) => List<DataModel>.from(json.decode(str).map((x) => DataModel.fromJson(x)));

String dataModelToJson(List<DataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
@HiveType(typeId: 0)
class DataModel extends HiveObject{
  DataModel({
    this.sealNo,
    this.date,
    this.containerSl,
    this.warehouse,
    this.materialNo,
    this.reelNo,
    this.quantity,
    this.imageUrls,
  });


  @HiveField(0)
  String? sealNo;
  @HiveField(1)
  String? date;
  @HiveField(2)
  String? containerSl;
  @HiveField(3)
  String? warehouse;
  @HiveField(4)
  String? materialNo;
  @HiveField(5)
  String? reelNo;
  @HiveField(6)
  String? quantity;
  @HiveField(7)
  List<String>? imageUrls;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    sealNo: json["seal_no"] == null ? null : json["seal_no"],
    date: json["date"] == null ? null : json["date"],
    containerSl: json["container_sl"] == null ? null : json["container_sl"],
    warehouse: json["warehouse"] == null ? null : json["warehouse"],
    materialNo: json["material_no"] == null ? null : json["material_no"],
    reelNo: json["reel_no"] == null ? null : json["reel_no"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    imageUrls: json["imageUrls"] == null ? null : List<String>.from(json["imageUrls"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "seal_no": sealNo == null ? null : sealNo,
    "date": date == null ? null : date,
    "container_sl": containerSl == null ? null : containerSl,
    "warehouse": warehouse == null ? null : warehouse,
    "material_no": materialNo == null ? null : materialNo,
    "reel_no": reelNo == null ? null : reelNo,
    "quantity": quantity == null ? null : quantity,
    "imageUrls": imageUrls == null ? null : List<String>.from(imageUrls!.map((x) => x)),
  };
}

