// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:fic_5/data/datasources/product_datasources.dart';
import 'package:fic_5/data/models/request/product_request_model.dart';
import 'package:fic_5/data/models/response/product_response_model.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final ProductDatasource datasource;
  UpdateProductBloc(
    this.datasource,
  ) : super(UpdateProductInitial()) {
    on<DoUpdateProductEvent>((event, emit) async {
      emit(UpdateProductLoading());
      final result =
          await datasource.updateProduct(model: event.model, id: event.id);
      result.fold((error) => emit(UpdateProductError(message: error)),
          (result) => emit(UpdateProductLoaded(data: result)));
    });
  }
}
