// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:fic_5/data/datasources/product_datasources.dart';
import 'package:fic_5/data/models/response/product_response_model.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  final ProductDatasource datasource;
  DetailProductBloc(
    this.datasource,
  ) : super(DetailProductInitial()) {
    on<GetDetailProductEvent>((event, emit) async {
      emit(DetailProductLoading());
      final result = await datasource.getDetailProduct(id: event.id);
      result.fold(
          (error) => emit(
                DetailProductError(message: error),
              ), (result) {
        emit(DetailProductLoaded(data: result));
      });
    });
  }
}
