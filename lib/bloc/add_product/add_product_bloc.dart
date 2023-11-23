// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic_5/data/models/request/product_request_model.dart';
import 'package:meta/meta.dart';

import 'package:fic_5/data/datasources/product_datasources.dart';
import 'package:fic_5/data/models/response/product_response_model.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductDatasource datasource;
  AddProductBloc(
    this.datasource,
  ) : super(AddProductInitial()) {
    on<DoAddProductEvent>((event, emit) async {
      emit(AddProductLoading());
      final result = await datasource.createProduct(event.model);
      result.fold(
        (error) => emit(AddProductError(message: error)),
        (data) => emit(AddProductLoaded(model: data)),
      );
    });
  }
}
