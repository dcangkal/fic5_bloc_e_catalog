part of 'detail_product_bloc.dart';

@immutable
sealed class DetailProductEvent {}

class GetDetailProductEvent extends DetailProductEvent {
  final int id;

  GetDetailProductEvent({required this.id});
}
