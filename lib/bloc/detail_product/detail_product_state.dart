part of 'detail_product_bloc.dart';

@immutable
sealed class DetailProductState {}

final class DetailProductInitial extends DetailProductState {}

class DetailProductLoading extends DetailProductState {}

class DetailProductLoaded extends DetailProductState {
  final ProductResponseModel data;

  DetailProductLoaded({required this.data});
}

class DetailProductError extends DetailProductState {
  final String message;

  DetailProductError({required this.message});
}
