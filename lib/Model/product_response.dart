import 'package:shopping/Model/product_model.dart';

class ProductResponce {
  int? productCount;
  List<Product>? products;

  ProductResponce({this.products, this.productCount});

  factory ProductResponce.fromJson(var json) {
    List<Product> _product = [];
    json['Products'].forEach((v) {
      _product.add(Product.fromJson(v));
    });

    return ProductResponce(
        products: _product, productCount: json["ProductCount"]);
  }

  Map<String, dynamic> toJson() {
    return {"Products": this.products, "ProductCount": this.productCount};
  }
}
