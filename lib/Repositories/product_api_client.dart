import 'package:dio/dio.dart';

import 'package:shopping/Constant/path.dart';
import 'package:shopping/Model/product_response.dart';

class ProductRepositories {
  Future<ProductResponce> fetchProduct() async {
    final dio = Dio();
    final url = kBaseUrl + kGetProductWithSize + kRetailerCode;
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      return ProductResponce.fromJson(response.data);
    }
    throw new Exception('error getting Product');
  }
}
