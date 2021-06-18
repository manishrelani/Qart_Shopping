part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class FetchProduct extends ProductEvent {}

class SearchProduct extends ProductEvent {
  final String? value;
  SearchProduct(this.value);
}
