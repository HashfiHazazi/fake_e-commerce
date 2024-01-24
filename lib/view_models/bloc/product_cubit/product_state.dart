part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductInitial {}

final class ProductLoaded extends ProductInitial {
  final List<ProductModel> productResult;

  ProductLoaded({required this.productResult});
}

final class ProductError extends ProductInitial {}
