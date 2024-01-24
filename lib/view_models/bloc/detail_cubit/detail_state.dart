part of 'detail_cubit.dart';

@immutable
sealed class DetailState {}

final class DetailInitial extends DetailState {}

final class DetailLoading extends DetailInitial {}

final class DetailLoaded extends DetailInitial {
  final DetailProductModel detailProductList;

  DetailLoaded({required this.detailProductList});
}

final class DetailError extends DetailInitial {}
