import 'package:shopping/Model/product_model.dart';

class DatabaseResponse {
  String? qrCode;
  String? option;
  Product? product;

  DatabaseResponse({this.option, this.product, this.qrCode});

  factory DatabaseResponse.fromJson(var json) {
    return DatabaseResponse(
        option: json["Option"],
        qrCode: json["QRCode"],
        product: Product.fromString(json["Product"]));
  }

  List<DatabaseResponse> fromList(var list) {
    List<DatabaseResponse> data = [];

    for (var i in list) {
      data.add(DatabaseResponse.fromJson(i));
    }
    return data;
  }
}
