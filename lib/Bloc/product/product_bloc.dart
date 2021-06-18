import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shopping/Model/product_model.dart';
import 'package:shopping/Model/product_response.dart';
import 'package:shopping/Repositories/product_api_client.dart';
import 'package:shopping/Service/DatabaseHelper.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial());
  final repository = ProductRepositories();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is FetchProduct) {
      yield ProductLoding();
      try {
        final ProductResponce productResponce = await repository.fetchProduct();
        await DatabseHelper.db.addProductInDB(productResponce.products!);
        final productList = await DatabseHelper.db.getProductfromSearch("");
        yield ProductLoded(productList: productList);
      } catch (_) {
        yield ProductError();
      }
    }

    if (event is SearchProduct) {
      yield ProductLoding();
      try {
        final productList =
            await DatabseHelper.db.getProductfromSearch(event.value!);
        yield ProductLoded(productList: productList);
      } catch (_) {
        yield ProductError();
      }
    }
  }
}
