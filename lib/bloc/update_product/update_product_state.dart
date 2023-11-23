part of 'update_product_bloc.dart';

@immutable
sealed class UpdateProductState {}

final class UpdateProductInitial extends UpdateProductState {}

class UpdateProductLoading extends UpdateProductState {}

class UpdateProductLoaded extends UpdateProductState {
  final ProductResponseModel data;

  UpdateProductLoaded({required this.data});
}

class UpdateProductError extends UpdateProductState {
  final String message;

  UpdateProductError({required this.message});
}
