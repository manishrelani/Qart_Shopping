part of 'product_bloc.dart';

@immutable
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoding extends ProductState {}

class ProductLoded extends ProductState {
  final List<Product> productList;

  ProductLoded({required this.productList});

  @override
  List<Object> get props => [productList];
}

class ProductError extends ProductState {}
